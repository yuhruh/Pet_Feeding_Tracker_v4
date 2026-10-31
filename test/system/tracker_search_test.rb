require "application_system_test_case"

# Searching the trackers on a phone: typing searches without taking the field
# away (the keyboard stays open), and the fields are wide enough to read.
class TrackerSearchTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @pet = pets(:one)
    @pet.trackers.delete_all
    @pet.trackers.create!(date: Date.new(2026, 9, 1), feed_time: Time.zone.parse("2026-09-01 08:00"), food_type: "Kibble", brand: "Aurora", description: "Duck", amount: 40, total_ate_amount: 40)
    @pet.trackers.create!(date: Date.new(2026, 9, 2), feed_time: Time.zone.parse("2026-09-02 08:00"), food_type: "Kibble", brand: "Orijen", description: "Six fish", amount: 30, total_ate_amount: 30)
  end

  def sign_in(user)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(user.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_no_selector "#email_address", wait: 10
  end

  # A phone's screen: Chrome's window can't be made narrower than 500px.
  def phone_width(width = 400)
    page.driver.browser.execute_cdp("Emulation.setDeviceMetricsOverride", width: width, height: 800, deviceScaleFactor: 2, mobile: true)
  end

  teardown { page.driver.browser.execute_cdp("Emulation.clearDeviceMetricsOverride") }

  def chart_dates(id)
    page.evaluate_script("document.getElementById('#{id}')?.chart?.getOption().xAxis[0].data")
  end

  test "typing a search keeps the field and its keyboard, the place on the page and the chart" do
    sign_in(@owner)
    phone_width
    visit pet_trackers_url(@pet, locale: LOCALE)
    assert_equal 2, chart_dates("pet-chart").size

    field = find_field("brand")
    page.execute_script("arguments[0].dataset.typedIn = 'yes'", field)
    field.click
    scrolled = page.evaluate_script("window.scrollY")
    field.send_keys "Aur"

    assert_current_path(/brand=Aur/, wait: 5)
    assert_no_text "Orijen"
    # The same field, still focused: a replaced field would have closed a phone's keyboard.
    assert_equal "yes", page.evaluate_script("document.activeElement.dataset.typedIn")
    assert_in_delta scrolled, page.evaluate_script("window.scrollY"), 50
    assert_equal [ "26/09/01" ], chart_dates("pet-chart")

    field.send_keys "ora"
    assert_current_path(/brand=Aurora/, wait: 5)
    assert_equal "Aurora", find_field("brand").value
  end

  test "the keyboard's Search key searches at once" do
    sign_in(@owner)
    phone_width
    visit pet_trackers_url(@pet, locale: LOCALE)
    find_field("brand").send_keys "Orijen", :enter
    assert_current_path(/brand=Orijen/, wait: 0.9) # before the typing delay would have searched
    assert_no_text "Aurora"
  end

  test "every search field is wide enough to read what is typed, on a phone and on a laptop" do
    sign_in(@owner)
    [ 360, 480, 699, 960, 1200 ].each do |width|
      phone_width(width)
      visit pet_trackers_url(@pet, locale: LOCALE)
      %w[food_type brand description note].each do |name|
        assert_operator page.evaluate_script("document.getElementById('#{name}').getBoundingClientRect().width"), :>=, 150, "#{name} at #{width}px"
      end
      wide = page.evaluate_script(<<~JS)
        [...document.querySelectorAll('#trackers form:first-child *')].filter(e => e.getBoundingClientRect().right > #{width}).map(e => e.tagName + '#' + e.id)
      JS
      assert_empty wide, "search fields wider than the screen at #{width}px"
    end
  end
end
