import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['tz'];

  connect() {
    this.tzTarget.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
    console.log("Timezone set in hidden field:", this.tzTarget.value);
  }
}
