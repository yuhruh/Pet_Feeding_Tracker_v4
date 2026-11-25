# Spreadsheet programs run a cell that starts with = + - or @ (or a tab or a
# return) as a formula, so text someone typed (a note, a brand, a name) could
# make the owner's spreadsheet fetch a web address or run a command. A leading
# apostrophe makes the cell plain text. Numbers and dates are left alone.
#
# The files use ';' between columns, but Excel opened by double-click splits on
# the system's list separator, which is ',' in English, Chinese and Japanese.
# Then "ok,=cmd…" becomes a cell of its own starting with '=', so the same mark
# also goes after a ',', ';', tab or line break inside the text.
module CsvSafe
  FORMULA_START = /\A[=+\-@\t\r]/
  ESCAPED = /\A'[=+\-@\t\r]/
  INNER_FORMULA_START = /([,;\t\r\n])([=+\-@])/
  INNER_ESCAPED = /([,;\t\r\n])'([=+\-@])/

  def self.cell(value)
    return value unless value.is_a?(String)

    value = value.gsub(INNER_FORMULA_START, "\\1'\\2")
    value.match?(FORMULA_START) ? "'#{value}" : value
  end

  def self.row(values) = values.map { |value| cell(value) }

  # The reverse, for importing a file this app exported.
  def self.restore(value)
    return value unless value.is_a?(String)

    value = value[1..] if value.match?(ESCAPED)
    value.gsub(INNER_ESCAPED, "\\1\\2")
  end
end
