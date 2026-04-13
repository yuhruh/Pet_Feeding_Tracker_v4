import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "loader", "status", "form"]
  static values = {
    petId: String
  }

  connect() {
    console.log("OCR Upload Controller connected")
  }

  upload(event) {
    const files = event.target.files
    if (files.length === 0) return

    this.showLoader()
    const fileCount = files.length
    
    // Use data attributes for translated strings passed from the view
    const pageWord = fileCount > 1 ? this.element.dataset.ocrUploadPagePluralValue : this.element.dataset.ocrUploadPageSingularValue
    const statusMsg = this.element.dataset.ocrUploadStatusReadingValue.replace("%{count}", fileCount).replace("%{pages}", pageWord)
    
    this.setStatus(statusMsg)

    const formData = new FormData()
    for (let i = 0; i < files.length; i++) {
      formData.append("files[]", files[i])
    }

    // Get CSRF token and current locale from URL or HTML lang attribute
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content
    const currentLocale = document.documentElement.lang || "en"

    fetch(`/pets/${this.petIdValue}/health_checks/extract_data?locale=${currentLocale}`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken
      },
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        const errorMsg = this.element.dataset.ocrUploadStatusErrorValue.replace("%{error}", data.error)
        this.setStatus(errorMsg, "text-red-500")
      } else {
        this.fillForm(data)
        this.setStatus(this.element.dataset.ocrUploadStatusSuccessValue, "text-green-600")
      }
    })
    .catch(error => {
      console.error("OCR Error:", error)
      this.setStatus(this.element.dataset.ocrUploadStatusFailedValue, "text-red-500")
    })
    .finally(() => {
      this.hideLoader()
    })
  }

  fillForm(data) {
    console.log("Filling form with data:", data)
    // Mapping of JSON keys to input IDs
    // The input IDs follow the pattern health_check_FIELDNAME
    Object.keys(data).forEach(key => {
      const value = data[key]
      if (value === null || value === undefined) return

      let element = document.getElementById(`health_check_${key}`)
      
      // Handle the specific ID for osm-cal if it differs
      if (!element && key === "osm_cal") {
        element = document.getElementById("health_check_osm-cal")
      }

      if (element) {
        element.value = value
        // Highlight changed field using a border/ring instead of background to avoid dark mode text issues
        element.classList.add("ring-2", "ring-green-500", "transition-all", "duration-500")
        setTimeout(() => element.classList.remove("ring-2", "ring-green-500"), 5000)
      }
    })
  }

  showLoader() {
    this.loaderTarget.classList.remove("hidden")
  }

  hideLoader() {
    this.loaderTarget.classList.add("hidden")
  }

  setStatus(message, colorClass = "text-gray-600") {
    this.statusTarget.textContent = message
    this.statusTarget.className = `text-sm font-semibold mt-2 ${colorClass}`
  }
}
