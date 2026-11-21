require "test_helper"
require "csv"

# Text that a spreadsheet would run as a formula is exported as plain text.
class CsvSafeTest < ActiveSupport::TestCase
  test "text starting with = + - @ tab or return gets a leading apostrophe; everything else is untouched" do
    assert_equal "'=HYPERLINK(\"http://x\")", CsvSafe.cell('=HYPERLINK("http://x")')
    assert_equal "'+1", CsvSafe.cell("+1")
    assert_equal "'-ate less", CsvSafe.cell("-ate less")
    assert_equal "'@SUM(A1)", CsvSafe.cell("@SUM(A1)")
    assert_equal "'\tx", CsvSafe.cell("\tx")

    assert_equal "ate = all of it", CsvSafe.cell("ate = all of it")
    assert_equal(-1.5, CsvSafe.cell(-1.5))
    assert_equal Date.new(2026, 3, 10), CsvSafe.cell(Date.new(2026, 3, 10))
    assert_nil CsvSafe.cell(nil)
  end

  test "restore takes the apostrophe off again, and only that one" do
    assert_equal "=1+1", CsvSafe.restore("'=1+1")
    assert_equal "'quoted'", CsvSafe.restore("'quoted'")
    assert_equal "plain", CsvSafe.restore("plain")
    assert_nil CsvSafe.restore(nil)
  end

  test "the care records download neutralizes a caregiver's note" do
    CareEvent.create!(pet: pets(:one), kind: :weight, value: 4.2, note: '=HYPERLINK("http://evil.example","x")', actor: users(:one), occurred_at: Time.current)
    rows = CSV.parse(CareRecordsCsv.new(households(:one), ApplicationController.helpers).to_csv, col_sep: ";")
    cells = rows.flatten.compact
    assert_includes cells, %('=HYPERLINK("http://evil.example","x"))
    assert_empty cells.grep(/\A[=+@]/)
  end

  test "the trackers download neutralizes text, and importing it gives the text back" do
    pet = pets(:one)
    tracker = Tracker.new(date: Date.new(2026, 3, 10), feed_time: Time.utc(2000, 1, 1, 2, 0), food_type: "Wet", brand: "=cmd|' /c calc'!a0",
                          description: "@home", amount: 50, left_amount: 10, note: "+SUM(1)", weight: 4.2)
    csv = Tracker.to_csv([ tracker ], "UTC")
    row = CSV.parse(csv, col_sep: ";", headers: true).first.fields
    assert_includes row, "'=cmd|' /c calc'!a0"
    assert_includes row, "'@home"
    assert_includes row, "'+SUM(1)"
    assert_includes row, "50.0", "numbers stay numbers"

    file = Tempfile.new([ "trackers", ".csv" ]).tap { |f| f.write(csv); f.close }
    service = CsvImportTrackersService.new(pet, users(:one))
    assert service.call(file.path), service.errors.join(", ")
    imported = pet.trackers.order(:id).last
    assert_equal [ "=cmd|' /c calc'!a0", "@home", "+SUM(1)" ], [ imported.brand, imported.description, imported.note ]
  end
end
