# Spreadsheet programs run a cell that starts with = + - or @ (or a tab or a
# return) as a formula, so text someone typed (a note, a brand, a name) could
# make the owner's spreadsheet fetch a web address or run a command. A leading
# apostrophe makes the cell plain text. Numbers and dates are left alone.
module CsvSafe
  FORMULA_START = /\A[=+\-@\t\r]/
  ESCAPED = /\A'[=+\-@\t\r]/

  def self.cell(value) = value.is_a?(String) && value.match?(FORMULA_START) ? "'#{value}" : value

  def self.row(values) = values.map { |value| cell(value) }

  # The reverse, for importing a file this app exported.
  def self.restore(value) = value.is_a?(String) && value.match?(ESCAPED) ? value[1..] : value
end
