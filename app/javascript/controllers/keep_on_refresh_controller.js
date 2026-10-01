import { Controller } from "@hotwired/stimulus"

// Keeps an element when a live update refreshes the page without it (someone
// else's change), so the saved notice stays open. A new version of it from the
// server (your next tap) still replaces it, and leaving the page removes it.
export default class extends Controller {
  keep(event) {
    if (event.target === this.element && !event.detail.newElement) event.preventDefault()
  }
}
