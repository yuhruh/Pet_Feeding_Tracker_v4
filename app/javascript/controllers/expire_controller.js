import { Controller } from "@hotwired/stimulus"

// Removes the element once its time is up (the 10-second Undo button).
export default class extends Controller {
  static values = { after: Number }

  connect() {
    this.timer = setTimeout(() => this.element.remove(), Math.max(this.afterValue, 0))
  }

  disconnect() {
    clearTimeout(this.timer)
  }
}
