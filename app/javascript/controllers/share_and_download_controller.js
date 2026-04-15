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
    
    // Chartkick with Google Charts adapter
    const chart = Chartkick.charts[this.chartIdValue]
    if (!chart) {
      console.error("Chart not found")
      return
    }

    const googleChart = chart.getChartObject()
    if (googleChart && typeof googleChart.getImageURI === 'function') {
      const uri = googleChart.getImageURI()
      const link = document.createElement('a')
      link.download = `${this.filenameValue || 'chart'}.png`
      link.href = uri
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
    } else {
      alert("Chart is still loading or not ready for download. Please try again in a moment.")
    }
  }
}
