import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "selectAll", "checkbox" ]

  connect() {
    this.updateSelectAll()
  }

  toggleAll() {
    this.checkboxTargets.forEach(checkbox => {
      checkbox.checked = this.selectAllTarget.checked
    })
  }

  updateSelectAll() {
    const allChecked = this.checkboxTargets.every(checkbox => checkbox.checked)
    const someChecked = this.checkboxTargets.some(checkbox => checkbox.checked)

    this.selectAllTarget.checked = allChecked
    this.selectAllTarget.indeterminate = !allChecked && someChecked
  }
}