import { Controller } from "@hotwired/stimulus"
import * as echarts from "echarts"

// Draws an Apache ECharts chart from the options ChartsHelper puts in
// data-echart-options-value, and adds what JSON can't carry: colors for light
// or dark mode, units in the tooltip, and a zoom slider that opens on the
// latest days when there are more than fit (dayWidth pixels each, at most
// visibleDays).
//
// A tracker search morphs the page: the chart keeps its drawing and is given
// the new options instead of being emptied by the morph.
//
// Connects to data-controller="echart"
export default class extends Controller {
  static values = { options: Object, visibleDays: Number, dayWidth: { type: Number, default: 15 } }

  connect() {
    this.chart = echarts.init(this.element)
    this.element.chart = this.chart // for the PNG download and the system tests
    this.draw()

    this.resizeObserver = new ResizeObserver(() => this.chart.resize())
    this.resizeObserver.observe(this.element)
    this.themeObserver = new MutationObserver(() => this.chart.setOption(this.colors()))
    this.themeObserver.observe(document.documentElement, { attributes: true, attributeFilter: ["class"] })
  }

  disconnect() {
    this.resizeObserver.disconnect()
    this.themeObserver.disconnect()
    this.chart.dispose()
    delete this.element.chart
  }

  optionsValueChanged() {
    if (this.chart) this.draw()
  }

  // turbo:before-morph-element: takes the new page's options, keeps the drawing.
  keep(event) {
    if (event.target !== this.element) return
    event.preventDefault()
    this.element.setAttribute("data-echart-options-value", event.detail.newElement.getAttribute("data-echart-options-value"))
  }

  draw() {
    const options = structuredClone(this.optionsValue)
    const days = [options.xAxis].flat()[0]?.data?.length || 0
    const fit = Math.max(5, Math.floor(this.element.clientWidth / this.dayWidthValue))
    const visible = Math.min(this.visibleDaysValue || days, fit)
    const zoom = days > visible

    options.series.forEach(series => {
      if (series.unit) series.tooltip = { valueFormatter: value => (value == null ? "–" : `${value} ${series.unit}`) }
    })
    Object.assign(options, {
      backgroundColor: "transparent",
      textStyle: { fontFamily: getComputedStyle(document.body).fontFamily },
      legend: { type: "scroll", top: 0 },
      tooltip: { trigger: "axis", axisPointer: { type: "shadow" }, confine: true },
      grid: { left: 12, right: 12, top: 56, bottom: zoom ? 44 : 12, containLabel: true },
      dataZoom: zoom ? [
        { type: "inside", startValue: days - visible, endValue: days - 1, minValueSpan: 4 },
        { type: "slider", height: 18, bottom: 8, startValue: days - visible, endValue: days - 1, brushSelect: false }
      ] : []
    })
    this.chart.setOption(options, { notMerge: true })
    this.chart.setOption(this.colors())
  }

  // Text and gridline colors for the page's light or dark mode.
  colors() {
    const dark = document.documentElement.classList.contains("dark")
    const text = dark ? "#e5e7eb" : "#374151"
    const muted = dark ? "#cbd5e1" : "#4b5563"
    const line = dark ? "#334155" : "#e5e7eb"
    const axis = { nameTextStyle: { color: muted, fontWeight: "bold" }, axisLabel: { color: muted }, axisLine: { lineStyle: { color: line } }, splitLine: { lineStyle: { color: line } } }
    const axes = key => [this.optionsValue[key]].flat().map(() => axis)
    return {
      legend: { textStyle: { color: text }, pageTextStyle: { color: text } },
      xAxis: axes("xAxis").map(a => ({ ...a, axisLabel: { color: muted, rotate: 45, fontSize: 10 } })),
      yAxis: axes("yAxis"),
      dataZoom: [{}, { textStyle: { color: muted }, borderColor: line }]
    }
  }
}
