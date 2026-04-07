module HealthChecksHelper
  def range_row_class(actual, high, low)
    return "text-center font-normal dark:text-gray-800" if actual.nil?

    classes = []
    if actual.to_f > high
      classes << "text-center text-red-700 font-bold italic"
    elsif actual.to_f < low
      classes << "text-center text-sky-700 font-bold italic"
    else
      classes << "text-center font-normal dark:text-gray-800"
    end
    classes.join(" ")
  end
end
