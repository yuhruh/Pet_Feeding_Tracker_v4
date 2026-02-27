import { Controller } from "@hotwired/stimulus";
import { I18n } from "i18n-js";
import translations from "translations";

export default class extends Controller {
  static targets = ["leftAmount", "leftAmountAlert", "totalAteAmount", "separator", "submitButton"];

  connect() {
    this.originalAmount = parseFloat(this.leftAmountTarget.max);
    this.i18n = new I18n(translations);
    this.i18n.locale = document.documentElement.lang || "en";
  }

  validateLeftAmount() {
    const leftAmount = parseFloat(this.leftAmountTarget.value);
    const isValid = !isNaN(leftAmount) && leftAmount <= this.originalAmount;

    this.#toggleSubmitButton(isValid);
    this.#updateAlerts(leftAmount, isValid);
    this.#updateTotalAteAmount(leftAmount, isValid);
  }

  #toggleSubmitButton(enabled) {
    this.submitButtonTarget.disabled = !enabled;
    if (enabled) {
      this.submitButtonTarget.classList.add("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
      this.submitButtonTarget.classList.remove("bg-gray-400", "cursor-not-allowed");
    } else {
      this.submitButtonTarget.classList.remove("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
      this.submitButtonTarget.classList.add("bg-gray-400", "cursor-not-allowed");
    }
  }

  #updateAlerts(leftAmount, isValid) {
    if (isNaN(leftAmount) || !this.leftAmountTarget.value) {
      this.leftAmountAlertTarget.classList.add('hidden');
      this.separatorTarget.classList.add('hidden');
      return;
    }

    this.leftAmountAlertTarget.classList.remove('hidden');

    if (isValid) {
      this.leftAmountAlertTarget.textContent = this.i18n.t('javascript.left_amount_controller.valid_amount', { amount: leftAmount });
      this.leftAmountAlertTarget.classList.replace("text-red-500", "text-green-500");
    } else {
      this.leftAmountAlertTarget.textContent = this.i18n.t('javascript.left_amount_controller.greater_than_alert', { amount: this.originalAmount });
      this.leftAmountAlertTarget.classList.replace("text-green-500", "text-red-500");
    }
  }

  #updateTotalAteAmount(leftAmount, isValid) {
    if (isValid && this.leftAmountTarget.value) {
      const ateAmount = this.originalAmount - leftAmount;
      this.totalAteAmountTarget.textContent = this.i18n.t('javascript.left_amount_controller.total_ate', { amount: ateAmount.toFixed(2) });
      this.separatorTarget.classList.remove('hidden');
      this.totalAteAmountTarget.classList.remove('hidden');
    } else {
      this.totalAteAmountTarget.classList.add('hidden');
      this.separatorTarget.classList.add('hidden');
    }
  }
}
