require "application_system_test_case"

# On a phone or tablet, the litter box and water spot rows stay inside their list
# and the page doesn't scroll sideways.
class HouseholdPageLayoutTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @household = households(:one)
    @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    @household.care_spots.create!(kind: :water_fountain, name: "Study Room")
  end

  teardown { page.driver.browser.execute_cdp("Emulation.clearDeviceMetricsOverride") }

  def screen(width)
    page.driver.browser.execute_cdp("Emulation.setDeviceMetricsOverride", width: width, height: 800, deviceScaleFactor: 2, mobile: true)
  end

  test "care spot rows and the forms fit on small screens" do
    sign_in_as(@owner)
    [ 320, 375, 600, 800 ].each do |width|
      screen(width)
      visit household_url(locale: LOCALE)

      outside = page.evaluate_script(<<~JS)
        (() => {
          const list = document.querySelector("#care_spots ul").getBoundingClientRect();
          return [...document.querySelectorAll("#care_spots ul li *")]
            .filter((el) => el.getBoundingClientRect().width > 0 && el.getBoundingClientRect().right > list.right + 0.5)
            .map((el) => el.outerHTML.slice(0, 80));
        })()
      JS
      assert_empty outside, "at #{width}px"
      assert_equal width, page.evaluate_script("document.documentElement.scrollWidth"), "no sideways scrolling at #{width}px"
    end
  end
end
