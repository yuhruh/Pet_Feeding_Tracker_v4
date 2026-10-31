require "application_system_test_case"

# The amount chart drawn by echart_controller.js: the zoom slider appears only
# when there are more days than it opens on, and dark mode restyles the chart
# without adding to it.
class TrackerChartTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @pet = pets(:one)
    @pet.trackers.delete_all
    @pet.share!
  end

  def feed(days)
    days.times { |i| @pet.trackers.create!(date: Date.new(2026, 9, 1) + i, feed_time: "08:00", food_type: "Wet", brand: "Ciao", description: "Tuna", amount: 120, total_ate_amount: 100) }
  end

  def chart(js) = page.evaluate_script("(c => #{js})(document.getElementById('pet-chart').chart)")

  def open_shared_page
    visit shared_pet_trackers_url(share_token: @pet.share_token, locale: LOCALE)
    assert_selector "#pet-chart canvas", wait: 10
  end

  test "a few days get no zoom slider, in light or dark mode" do
    feed(8)
    open_shared_page
    assert_equal 8, chart("c.getOption().xAxis[0].data.length")
    assert_equal 0, chart("c.getOption().dataZoom.length")
    page.execute_script("document.documentElement.classList.add('dark')")
    assert_equal 0, chart("c.getOption().dataZoom.length"), "dark mode added a slider"
  end

  test "many days open on the latest 30 with a slider for the rest" do
    feed(45)
    open_shared_page
    assert_equal 2, chart("c.getOption().dataZoom.length")
    assert_equal [ 15, 44 ], chart("[c.getOption().dataZoom[0].startValue, c.getOption().dataZoom[0].endValue]")
  end
end
