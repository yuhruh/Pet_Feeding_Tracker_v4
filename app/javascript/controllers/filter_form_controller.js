import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-form"
export default class extends Controller {
  timeout = null

  submit() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 300)
  }
}
