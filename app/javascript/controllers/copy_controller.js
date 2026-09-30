import { Controller } from "@hotwired/stimulus"

// Copies a value to the clipboard: <button data-controller="copy" data-copy-text-value="…" data-action="copy#copy">
export default class extends Controller {
  static values = { text: String, done: String }

  copy() {
    navigator.clipboard.writeText(this.textValue).then(() => {
      if (this.hasDoneValue) this.element.textContent = this.doneValue
    })
  }
}
