import { Controller } from "@hotwired/stimulus"

// Fades out and removes the element it is attached to: flash messages, form
// error boxes and banners. Replaces inline onclick= handlers, which the
// Content-Security-Policy blocks.
//
//   <div data-controller="dismiss"> ... <button data-action="dismiss#close">×</button></div>
export default class extends Controller {
  close() {
    this.element.style.transition = "opacity 300ms ease-in"
    this.element.style.opacity = "0"
    setTimeout(() => this.element.remove(), 300)
  }
}
