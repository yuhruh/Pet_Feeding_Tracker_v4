import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "loader", "status", "form"]
  static values = {
    petId: String,
    // Limits and messages from GeminiOcrService, rendered by the view
    maxFiles: Number,
    maxFileSize: Number,
    maxTotalSize: Number,
    tooManyMessage: String,
    fileTooLargeMessage: String,
    totalTooLargeMessage: String
  }

  connect() {
    console.log("OCR Upload Controller connected")
  }

  // The same count and size limits the server enforces, checked before uploading so
  // the user doesn't wait for an upload that will be refused. The file type is only
  // checked on the server, from each file's contents.
  limitError(files) {
    if (this.hasMaxFilesValue && files.length > this.maxFilesValue) return this.tooManyMessageValue
    const sizes = Array.from(files, file => file.size)
    if (this.hasMaxFileSizeValue && sizes.some(size => size > this.maxFileSizeValue)) return this.fileTooLargeMessageValue
    if (this.hasMaxTotalSizeValue && sizes.reduce((sum, size) => sum + size, 0) > this.maxTotalSizeValue) return this.totalTooLargeMessageValue
    return null
  }

  upload(event) {
    const files = event.target.files
    if (files.length === 0) return

    const limitError = this.limitError(files)
    if (limitError) {
      this.setStatus(this.element.dataset.ocrUploadStatusErrorValue.replace("%{error}", limitError), "text-red-500")
      event.target.value = "" // lets the user choose again, even the same files
      return
    }

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
    // Rails omits the CSRF meta tag when forgery protection is off (as in tests),
    // so don't assume it exists: reading .content of null would stop the upload.
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
    const currentLocale = document.documentElement.lang || "en"

    fetch(`/pets/${this.petIdValue}/health_checks/extract_data?locale=${currentLocale}`, {
      method: "POST",
      headers: csrfToken ? { "X-CSRF-Token": csrfToken } : {},
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
