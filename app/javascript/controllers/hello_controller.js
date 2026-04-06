import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = I18n.t('javascript.hello_controller.hello_world')
  }
}
