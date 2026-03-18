import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  toggleForm(event) {
    if (event.target.value === "custom") {
      this.formTarget.classList.remove("hidden")
    } else {
      this.formTarget.classList.add("hidden")
      event.target.form.submit();
    }
  }
}
