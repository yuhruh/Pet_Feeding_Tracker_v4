import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["leftAmount", "leftAmountAlert", "totalAteAmount", "separator", "submitButton", "pencilBrand", "pencilDescription", "brand", "description"];

  connect() {
    console.log("LeftAmount controller connected and ready");
    this.originalAmount = parseFloat(this.leftAmountTarget.max);
  }

  toggleReadonly(event) {
    const targetName = event.currentTarget.dataset.targetName
    const input = targetName === 'brand' ? this.brandTarget : this.descriptionTarget
    
    console.log(`Pencil clicked for: ${targetName}. Current readonly state: ${input.readOnly}`);
    
    if (input.readOnly) {
      input.readOnly = false
      input.classList.remove('bg-gray-100', 'dark:bg-gray-300')
      input.classList.add('bg-white')
      input.focus()
      event.currentTarget.classList.add('text-softBlue', 'scale-110')
    } else {
      input.readOnly = true
      input.classList.add('bg-gray-100', 'dark:bg-gray-300')
      input.classList.remove('bg-white')
      event.currentTarget.classList.remove('text-softBlue', 'scale-110')
    }
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
      this.leftAmountAlertTarget.textContent = I18n.t('javascript.left_amount_controller.valid_amount', { amount: leftAmount });
      this.leftAmountAlertTarget.classList.replace("text-red-500", "text-green-500");
    } else {
      this.leftAmountAlertTarget.textContent = I18n.t('javascript.left_amount_controller.greater_than_alert', { amount: this.originalAmount });
      this.leftAmountAlertTarget.classList.replace("text-green-500", "text-red-500");
    }
  }

  #updateTotalAteAmount(leftAmount, isValid) {
    if (isValid && this.leftAmountTarget.value) {
      const ateAmount = this.originalAmount - leftAmount;
      this.totalAteAmountTarget.textContent = I18n.t('javascript.left_amount_controller.total_ate', { amount: ateAmount.toFixed(2) });
      this.separatorTarget.classList.remove('hidden');
      this.totalAteAmountTarget.classList.remove('hidden');
    } else {
      this.totalAteAmountTarget.classList.add('hidden');
      this.separatorTarget.classList.add('hidden');
    }
  }
}
