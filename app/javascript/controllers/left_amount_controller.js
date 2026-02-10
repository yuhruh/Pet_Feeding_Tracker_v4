import { Controller } from "@hotwired/stimulus";
import { I18n } from "i18n-js";
import translations from "translations";

export default class extends Controller {
  static targets = ["leftAmount", "leftAmountAlert", "submitButton"];
  
  connect() {
    this.originalAmount = parseFloat(this.leftAmountTarget.max);
    const i18n = new I18n(translations);
    this.i18n = i18n;
    this.i18n.locale = document.documentElement.lang || "en";
    console.log("Translations loaded:", translations);
  }

  validateLeftAmount() {
    const inputleftAmount = parseFloat(this.leftAmountTarget.value);
    if (inputleftAmount > this.originalAmount) {
      this.leftAmountAlertTarget.textContent = this.i18n.t('javascript.left_amount_controller.greater_than_alert', { amount: this.originalAmount });
      this.leftAmountAlertTarget.classList.remove('hidden');
      this.leftAmountAlertTarget.classList.replace("text-green-500", "text-red-500");
      this.submitButtonTarget.disabled = true;
      this.submitButtonTarget.classList.remove("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
      this.submitButtonTarget.classList.add("bg-gray-400", "cursor-not-allowed");
    } else {
      this.leftAmountAlertTarget.textContent = this.i18n.t('javascript.left_amount_controller.valid_amount', { amount: inputleftAmount });
      this.leftAmountAlertTarget.classList.remove('hidden');
      this.leftAmountAlertTarget.classList.replace("text-red-500", "text-green-500");
      this.submitButtonTarget.disabled = false;
      this.submitButtonTarget.classList.add("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
      this.submitButtonTarget.classList.remove("bg-gray-400", "cursor-not-allowed");
    }
  }
}