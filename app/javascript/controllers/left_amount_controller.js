import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["leftAmount", "leftAmountAlert", "submitButton"];
  
  connect() {
    this.originalAmount = parseFloat(this.leftAmountTarget.max);
  }

  validateLeftAmount() {
    const inputleftAmount = parseFloat(this.leftAmountTarget.value);
    if (inputleftAmount > this.originalAmount) {
      this.leftAmountAlertTarget.textContent = `Should not greater than ${this.originalAmount}g.`;
      this.leftAmountAlertTarget.classList.remove('hidden');
      this.leftAmountAlertTarget.classList.replace("text-green-500", "text-red-500");
      this.submitButtonTarget.disabled = true;
      this.submitButtonTarget.classList.remove("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
      this.submitButtonTarget.classList.add("bg-gray-400", "cursor-not-allowed");
    } else {
      this.leftAmountAlertTarget.textContent = `${inputleftAmount}g is valid.`;
      this.leftAmountAlertTarget.classList.remove('hidden');
      this.leftAmountAlertTarget.classList.replace("text-red-500", "text-green-500");
      this.submitButtonTarget.disabled = false;
      this.submitButtonTarget.classList.add("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
      this.submitButtonTarget.classList.remove("bg-gray-400", "cursor-not-allowed");
    }
  }
}