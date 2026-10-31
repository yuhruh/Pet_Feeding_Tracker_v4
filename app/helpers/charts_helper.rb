# ECharts options for the trackers charts, drawn by echart_controller.js, which
# adds the colors for light or dark mode, the tooltip units and the zoom slider.
module ChartsHelper
  AMOUNT_COLORS = %w[#C1D7EC #2563EB #FFDAB9 #F97316 #6B4AB9].freeze

  # The four food series stacked by day, and the weight line on its own axis.
  # data is TrackersCalculable's chart_data: four { name:, data: { "yy/mm/dd" => g } } and the weight last.
  def amount_chart_options(data, min_weight:, max_weight:)
    *food, weight = data
    dates = food.first[:data].keys
    {
      color: AMOUNT_COLORS,
      xAxis: { type: "category", data: dates },
      yAxis: [
        { type: "value", name: t("trackers.index.chart_v_axis_amount") },
        { type: "value", name: t("trackers.index.chart_v_axis_weight"), nameTextStyle: { align: "right" }, min: min_weight, max: max_weight, splitLine: { show: false } }
      ],
      series: food.map { |series| { name: series[:name], type: "bar", stack: "amount", barCategoryGap: "25%", data: series[:data].values, unit: "g" } } +
        [ { name: weight[:name], type: "line", yAxisIndex: 1, data: dates.map { |date| weight[:data][date] }, connectNulls: true, symbolSize: 7, unit: "kg" } ]
    }
  end

  def care_chart_options(care)
    {
      color: CareChart::COLORS,
      xAxis: { type: "category", data: care.dates.map { |date| date.strftime("%y/%m/%d") } },
      yAxis: { type: "value", minInterval: 1 },
      series: care.series.map { |series| { name: series[:name], type: "bar", barGap: "10%", data: series[:data].values } }
    }
  end
end
