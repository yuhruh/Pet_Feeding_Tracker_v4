import { Controller } from "@hotwired/stimulus"

// Password field helpers that reveal nothing about the account: a show/hide
// toggle to check for typos, and a Caps Lock warning while typing.
//
//   <div data-controller="password-field" data-password-field-show-label-value="Show" data-password-field-hide-label-value="Hide">
//     <input type="password" data-password-field-target="input"
//            data-action="keyup->password-field#checkCapsLock blur->password-field#hideCapsLock">
//     <button type="button" data-password-field-target="toggle" data-action="password-field#toggle">Show</button>
//     <p hidden data-password-field-target="capsWarning">Caps Lock is on</p>
//   </div>
export default class extends Controller {
  static targets = ["input", "toggle", "capsWarning"]
  static values = { showLabel: String, hideLabel: String }

  toggle() {
    const show = this.inputTarget.type === "password"
    this.inputTarget.type = show ? "text" : "password"
    this.toggleTarget.textContent = show ? this.hideLabelValue : this.showLabelValue
    this.toggleTarget.setAttribute("aria-pressed", String(show))
    this.inputTarget.focus()
  }

  checkCapsLock(event) {
    if (typeof event.getModifierState !== "function") return
    this.capsWarningTarget.hidden = !event.getModifierState("CapsLock")
  }

  hideCapsLock() {
    this.capsWarningTarget.hidden = true
  }
}
