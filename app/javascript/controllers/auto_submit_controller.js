import { Controller } from "@hotwired/stimulus"

// Submits the surrounding form when a field changes, e.g. a "per page" select.
// Replaces onchange="this.form.submit()", which the Content-Security-Policy blocks.
//
//   <select data-controller="auto-submit" data-action="change->auto-submit#submit">
export default class extends Controller {
  submit() {
    this.element.form.requestSubmit()
  }
}
