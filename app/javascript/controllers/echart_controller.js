import { Controller } from "@hotwired/stimulus"
import * as echarts from "echarts"

// Draws an Apache ECharts chart from the options ChartsHelper puts in
// data-echart-options-value, and adds what JSON can't carry: colors for light
// or dark mode, units in the tooltip, and a zoom slider that opens on the
// latest days when there are more than fit (dayWidth pixels each, at most
// visibleDays). A legend too wide for one line (six series on a phone) wraps,
// and the chart grows by those lines instead of paging the legend with arrows.
//
// A tracker search morphs the page: the chart keeps its drawing and is given
// the new options instead of being emptied by the morph.
//
// Connects to data-controller="echart"
export default class extends Controller {
  static values = { options: Object, visibleDays: Number, dayWidth: { type: Number, default: 15 } }

  connect() {
    this.height = this.element.clientHeight
    this.chart = echarts.init(this.element)
    this.element.chart = this.chart // for the PNG download and the system tests
    this.draw()

    this.resizeObserver = new ResizeObserver(() => {
      if (this.legendLines() !== this.lines) this.draw()
      else this.chart.resize()
    })
    this.resizeObserver.observe(this.element)
    this.themeObserver = new MutationObserver(() => this.chart.setOption(this.colors()))
    this.themeObserver.observe(document.documentElement, { attributes: true, attributeFilter: ["class"] })
  }

  disconnect() {
    this.resizeObserver.disconnect()
    this.themeObserver.disconnect()
    this.chart.dispose()
    delete this.element.chart
    this.element.style.height = `${this.height}px`
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

  // How many lines ECharts wraps the legend onto: each item is a 25px swatch,
  // 5px, its name and a 10px gap, inside 5px of padding on either side.
  legendLines() {
    const context = document.createElement("canvas").getContext("2d")
    context.font = `12px ${getComputedStyle(document.body).fontFamily}`
    const width = this.element.clientWidth - 10
    let lines = 1, x = 0
    for (const { name } of this.optionsValue.series) {
      const item = 25 + 5 + context.measureText(name).width + 10
      if (x > 0 && x + item - 10 > width) { lines++; x = 0 }
      x += item
    }
    return lines
  }

  draw() {
    const options = structuredClone(this.optionsValue)
    this.lines = this.legendLines()
    this.element.style.height = `${this.height + (this.lines - 1) * 22}px`
    this.chart.resize()

    const days = [options.xAxis].flat()[0]?.data?.length || 0
    const fit = Math.max(5, Math.floor(this.element.clientWidth / this.dayWidthValue))
    const visible = Math.min(this.visibleDaysValue || days, fit)
    const zoom = days > visible
    const axisNames = [options.yAxis].flat().some(axis => axis.name) // drawn above the chart

    options.series.forEach(series => {
      if (series.unit) series.tooltip = { valueFormatter: value => (value == null ? "–" : `${value} ${series.unit}`) }
    })
    Object.assign(options, {
      backgroundColor: "transparent",
      textStyle: { fontFamily: getComputedStyle(document.body).fontFamily },
      legend: { top: 0 },
      tooltip: { trigger: "axis", axisPointer: { type: "shadow" }, confine: true },
      grid: { left: 12, right: 12, top: (axisNames ? 34 : 14) + this.lines * 22, bottom: zoom ? 44 : 12, containLabel: true },
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
    const shade = dark ? "rgba(148, 163, 184, 0.1)" : "rgba(148, 163, 184, 0.12)"
    const axis = { nameTextStyle: { color: muted, fontWeight: "bold" }, axisLabel: { color: muted }, axisLine: { lineStyle: { color: line } }, splitLine: { lineStyle: { color: line } } }
    const axes = key => [this.optionsValue[key]].flat().map(() => axis)
    return {
      legend: { textStyle: { color: text } },
      xAxis: axes("xAxis").map(a => ({ ...a, axisLabel: { color: muted, rotate: 45, fontSize: 10 }, splitArea: { areaStyle: { color: ["transparent", shade] } } })),
      yAxis: axes("yAxis"),
      dataZoom: [{}, { textStyle: { color: muted }, borderColor: line }]
    }
  }
}
