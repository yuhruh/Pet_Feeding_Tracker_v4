import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["viewState", "editState", "editButton", "saveButton", "cancelButton"]

  connect() {
    console.log("BulkEditController connected successfully to the DOM!")
  }

  toggleEdit(event) {
    if (event) event.preventDefault()
    
    console.log("toggleEdit triggered! Elements found:")
    console.log("- viewStateTargets count:", this.viewStateTargets.length)
    console.log("- editStateTargets count:", this.editStateTargets.length)

    // Toggle visibility of view vs edit elements
    this.viewStateTargets.forEach(el => el.classList.toggle("hidden"))
    this.editStateTargets.forEach(el => el.classList.toggle("hidden"))

    // Toggle control panel buttons
    if (this.hasEditButtonTarget) {
      this.editButtonTarget.classList.toggle("hidden")
    }
    if (this.hasSaveButtonTarget) {
      this.saveButtonTarget.classList.toggle("hidden")
    }
    if (this.hasCancelButtonTarget) {
      this.cancelButtonTarget.classList.toggle("hidden")
    }
  }
}
