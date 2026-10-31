import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link", "buttonText"]
  static values = {
    shareUrl: String,
    chartId: String,
    filename: String
  }

  copy(event) {
    event.preventDefault()
    
    navigator.clipboard.writeText(this.shareUrlValue).then(() => {
      const originalText = this.buttonTextTarget.textContent
      this.buttonTextTarget.textContent = "Copied! ✅"
      setTimeout(() => {
        this.buttonTextTarget.textContent = originalText
      }, 2000)
    }).catch(err => {
      console.error('Failed to copy: ', err)
      alert("Could not copy link automatically. Please copy it from the address bar.")
    })
  }

  download(event) {
    event.preventDefault()
    
    // echart_controller.js keeps the chart on its element.
    const chart = document.getElementById(this.chartIdValue)?.chart
    if (!chart) {
      alert("Chart is still loading or not ready for download. Please try again in a moment.")
      return
    }

    // The page's own background, so the axis text stays readable in dark mode.
    const dark = document.documentElement.classList.contains("dark")
    const link = document.createElement('a')
    link.download = `${this.filenameValue || 'chart'}.png`
    link.href = chart.getDataURL({ type: "png", pixelRatio: 2, backgroundColor: dark ? getComputedStyle(document.body).backgroundColor : "#ffffff" })
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
  }
}
