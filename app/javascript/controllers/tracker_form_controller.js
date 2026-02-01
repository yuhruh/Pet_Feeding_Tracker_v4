import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["foodType", "dryFoodOptions", "dryFoodSelect", "brand", "description", "amount", "amountAlert", "submitButton"]
  static values = { dryFoods: Array }

  connect() {
    this.csrfToken = document.querySelector("meta[name='csrf-token']").content;
    this.selectedFoodLeftAmount = null; // Initialize storage state
    this.toggleDryFoodOptions()
  }

  async toggleDryFoodOptions() {
    const type = this.foodTypeTarget.value
    if (type === "Kibble" || type === "Freeze-Dried") {
      this.dryFoodOptionsTarget.classList.remove("hidden");

      const response = await fetch(`/dry_foods`, {
        headers: {
          "X-CSRF-Token": this.csrfToken,
          "Accept": "application/json"
        }
      })
      const data = await response.json()
      if (data.length === 0) {
        alert(`There is no storage in dry food. Please add it first.`);
        window.location.href = "/dry_foods/new";
      } else {
        const filteredFoods = data.filter(dry => dry.food_type === type);
        this.updateDryFoodOptions(filteredFoods);
        // this.validateAmount(filteredFoods);
      }
    } else {
      this.dryFoodOptionsTarget.classList.add("hidden");
    }
  }

  updateDryFoodOptions(foods) {
    this.dryFoodSelectTarget.innerHTML = `<option value="">Select A Dry Food</option>`;
    foods.forEach(food => {
      const option = document.createElement("option");
      option.value = food.id;
      if (food.left_amount < food.amount * 10/100) {
        option.text = `⚠️ ${food.brand} - ${food.description} (Left ${food.left_amount} g, should restock)`;
      } else {
        option.text = `${food.brand} - ${food.description} (Left ${food.left_amount} g)`;
      }
      this.dryFoodSelectTarget.add(option);
    });
  }

  async fillFields() {
    const foodId = this.dryFoodSelectTarget.value;

    if (foodId) {
      try {
        const response = await fetch(`/dry_foods/${foodId}`, {
          headers: {
            "X-CSRF-Token": this.csrfToken,
            "Accept": "application/json"
          }
        });

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        this.brandTarget.value = data.brand;
        this.descriptionTarget.value = data.description;
        // Store the left amount
        this.selectedFoodLeftAmount = data.left_amount;
        this.validateAmount()
      } catch (error) {
        console.error("Error fetching dry food data:", error);
        this.brandTarget.value = "";
        this.descriptionTarget.value = "";
        this.selectedFoodLeftAmount = null;
      }
    } else {
      this.brandTarget.value = "";
      this.descriptionTarget.value = "";
      this.selectedFoodLeftAmount = null;
    }
    this.validateAmount();
  }

  validateAmount() {
    const inputAmount = parseFloat(this.amountTarget.value);

    // only validate if we have a selected dry food and an input amount
    if (this.selectedFoodLeftAmount != null && !isNaN(inputAmount)) {
      if (inputAmount > this.selectedFoodLeftAmount) {
        this.amountAlertTarget.textContent = `⚠️ Only ${this.selectedFoodLeftAmount}g left in storage.`;
        this.amountAlertTarget.classList.remove('hidden');
        this.amountAlertTarget.classList.replace("text-green-500", "text-red-500");
        this.submitButtonTarget.disabled = true;
        this.submitButtonTarget.classList.remove("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
        this.submitButtonTarget.classList.add("bg-gray-400", "cursor-not-allowed");
      } else {
        this.amountAlertTarget.textContent = `${inputAmount}g is valid.`;
        this.amountAlertTarget.classList.remove('hidden');
        this.amountAlertTarget.classList.replace("text-red-500", "text-green-500");
        this.submitButtonTarget.disabled = false;
        this.submitButtonTarget.classList.add("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
        this.submitButtonTarget.classList.remove("bg-gray-400", "cursor-not-allowed");
      }
    } else {
      this.hideAlert();
      this.submitButtonTarget.disabled = false;
      this.submitButtonTarget.classList.add("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
      this.submitButtonTarget.classList.remove("bg-gray-400", "cursor-not-allowed");
    }
  }

  hideAlert() {
    this.amountAlertTarget.textContent = "";
    this.amountAlertTarget.classList.add("hidden");
  }
}
