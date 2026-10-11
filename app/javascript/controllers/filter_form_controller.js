import { Controller } from "@hotwired/stimulus"

// Searches the trackers a second after typing stops.
//
// The form carries data-turbo-action="replace" and the page morphs on refresh,
// so a search updates the page in place: the field keeps its focus, a phone's
// keyboard stays open and the page doesn't jump back to the top. A plain visit
// replaced the whole page instead, which closed the keyboard mid-word.
//
// Connects to data-controller="filter-form"
export default class extends Controller {
  timeout = null

  submit(event) {
    // 注音 or かな still being turned into characters; compositionend searches.
    if (event?.isComposing) return

    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 1000)
  }

  // The Search button or the keyboard's Search key searched already.
  cancel() {
    clearTimeout(this.timeout)
  }

  // Leaves the field being typed in as it is, so letters typed while the
  // search was loading aren't replaced by the ones it searched for.
  keepTypedField(event) {
    if (event.target === document.activeElement) event.preventDefault()
  }
}
