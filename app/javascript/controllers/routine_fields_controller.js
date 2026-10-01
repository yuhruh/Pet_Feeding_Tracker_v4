import { Controller } from "@hotwired/stimulus"

// A job's reminder line on the household page: shows the custom amount only for
// "Custom" and the time fields only for "At set times". Without JavaScript both
// show, and only the chosen one is saved.
export default class extends Controller {
  static targets = ["choice", "custom", "times"]

  connect() {
    this.show()
  }

  show() {
    const choice = this.choiceTarget.value
    // Tailwind's "hidden" class, since these spans are display: flex.
    this.customTarget.classList.toggle("hidden", choice !== "custom")
    this.timesTarget.classList.toggle("hidden", choice !== "set_times")
  }
}
