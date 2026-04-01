module HealthChecksHelper
  def range_row_class(actual, high, low)
    classes = [ "text-center" ]
    if actual.to_f > high
      classes << "text-red-700 font-bold italic"
    elsif actual.to_f < low
      classes << "text-sky-700 font-bold italic"
    else
      classes << "font-normal"
    end
    classes.join(" ")
  end
end
