require "application_system_test_case"

# The menus in the navigation bar keep working after the Today page refreshes
# itself (a tap redirects back to Today, which Turbo morphs in place).
class NavigationMenusTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @pet = pets(:one)
    @pet.update!(petname: "Aji")
    @box = households(:one).care_spots.create!(kind: :litter_box, name: "Upstairs box", position: 0)
  end

  def sign_in(user)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(user.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_no_selector "#email_address", wait: 10
  end

  def trackers_menu_toggles
    find(".btn[data-target='btn-2']").click
    assert_selector "#btn-2", visible: true
    find(".btn[data-target='btn-2']").click
    assert_selector "#btn-2", visible: :hidden
  end

  # Each tap redirects back to Today, which morphs and fires turbo:load again.
  def tap(button, on:)
    count = CareEvent.count
    find("#" + ActionView::RecordIdentifier.dom_id(*Array(on))).click_on button
    assert_selector "#care_notice"
    assert_equal count + 1, CareEvent.count
  end

  test "the Trackers menu opens and closes after taps on Today" do
    sign_in(@owner)
    visit today_url(locale: LOCALE)
    trackers_menu_toggles

    tap "🍽 Fed", on: [ @pet, :care ]
    trackers_menu_toggles
    tap "🚽 Scooped", on: @box
    trackers_menu_toggles
  end

  test "the dark mode switch flips once per click after a tap on Today" do
    sign_in(@owner)
    visit today_url(locale: LOCALE)
    tap "🍽 Fed", on: [ @pet, :care ]

    dark = page.evaluate_script("document.documentElement.classList.contains('dark')")
    find("#theme-toggle").click
    assert_equal !dark, page.evaluate_script("document.documentElement.classList.contains('dark')")
  end

  test "a click outside closes an open menu" do
    sign_in(@owner)
    visit today_url(locale: LOCALE)
    find(".btn[data-target='btn-2']").click
    assert_selector "#btn-2", visible: true
    page.driver.browser.action.move_to_location(10, 1000).click.perform # well below the menus
    assert_selector "#btn-2", visible: :hidden
  end

  test "on a phone, the menu button opens and closes the menu after a tap on Today" do
    sign_in(@owner)
    page.driver.browser.manage.window.resize_to(400, 900)
    visit today_url(locale: LOCALE)
    tap "🍽 Fed", on: [ @pet, :care ]

    find("#menu-btn").click
    assert_selector "#menu", visible: true
    within("#menu") { assert_no_link I18n.t("layouts.navigation.mobile.get_started"), href: new_registrations_path(locale: LOCALE) }
    # The ✕ sits above the Gemini key banner, which stays at the top of the screen.
    assert_selector "#gemini-key-banner"
    find("#menu-btn").click
    assert_selector "#menu", visible: :hidden
  ensure
    page.driver.browser.manage.window.resize_to(1400, 1400)
  end

  # The full bar from 1150px (the nav breakpoint in config/tailwind.config.js), the ☰ menu below it.
  test "the navigation bar shows every item from 1150px wide and the menu button below that" do
    sign_in(@owner)
    { 1149 => false, 1150 => true }.each do |width, full_bar|
      page.driver.browser.manage.window.resize_to(width, 900)
      inner = page.evaluate_script("window.innerWidth")
      page.driver.browser.manage.window.resize_to(width + (width - inner), 900) if inner != width
      visit today_url(locale: LOCALE)
      assert_equal width, page.evaluate_script("window.innerWidth")
      assert_selector ".btn[data-target='btn-2']", visible: full_bar ? true : :hidden
      assert_selector "#menu-btn", visible: full_bar ? :hidden : true
    end
  ensure
    page.driver.browser.manage.window.resize_to(1400, 1400)
  end

  test "an open phone menu closes when the window grows wide enough for the full bar" do
    sign_in(@owner)
    page.driver.browser.manage.window.resize_to(800, 900)
    visit today_url(locale: LOCALE)
    find("#menu-btn").click
    assert_selector "#menu", visible: true

    page.driver.browser.manage.window.resize_to(1400, 900)
    assert_selector "#menu", visible: :hidden
    assert_no_selector "#menu-btn.open", visible: :all

    page.driver.browser.manage.window.resize_to(800, 900)
    assert_selector "#menu-btn", visible: true
    assert_selector "#menu", visible: :hidden # it stays closed
  ensure
    page.driver.browser.manage.window.resize_to(1400, 1400)
  end

  test "the home page tabs switch panels" do
    visit home_url(locale: LOCALE)
    assert_selector ".panel-2", visible: :hidden
    find(".tab[data-target='panel-2']").click
    assert_selector ".panel-2", visible: true
    assert_selector ".panel-1", visible: :hidden
  end

  test "clicking an organ on the health checks page shows its report" do
    sign_in(@owner)
    visit pet_health_checks_url(@pet, locale: LOCALE)
    assert_selector "#liver", visible: :hidden
    find(".organ[data-target='liver']", match: :first).click
    assert_selector "#liver", visible: true
    assert_selector "#kidney", visible: :hidden
  end

  test "an open menu stays open when someone else's tap refreshes Today" do
    sign_in(@owner)
    visit today_url(locale: LOCALE)
    find(".btn[data-target='btn-2']").click
    assert_selector "#btn-2", visible: true

    page.execute_script("document.documentElement.dataset.refreshed = '0'; document.addEventListener('turbo:morph', () => document.documentElement.dataset.refreshed = '1', { once: true }); Turbo.session.refresh(location.href)")
    assert_selector "html[data-refreshed='1']"
    assert_selector "#btn-2", visible: true
  end
end
