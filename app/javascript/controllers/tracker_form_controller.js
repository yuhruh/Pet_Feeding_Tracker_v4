import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["foodType", "dryFoodOptions", "dryFoodSelect", "wetFoodOptions", "wetFoodSelect", "brand", "description", "amount", "amountAlert", "submitButton"]
  static values = {
    dryFoods: Array,
    trackerUrl: String,
    newDryFoodUrl: String
  }

  connect() {
    this.csrfToken = document.querySelector("meta[name='csrf-token']").content;
    this.selectedFoodLeftAmount = null; // Initialize storage state
    if (this.hasFoodTypeTarget) {
      this.toggleDryFoodOptions()
    }
  }

  async toggleDryFoodOptions() {
    if (!this.hasFoodTypeTarget) return;

    const type = this.foodTypeTarget.value;
    const pathParts = window.location.pathname.split('/');
    const locale = document.documentElement.lang || 'en';
    const dryFoodsUrl = `/${locale}/dry_foods.json`;

    if (type === "kibble" || type === "freeze_dried") {
      if (this.hasDryFoodOptionsTarget) this.dryFoodOptionsTarget.classList.remove("hidden");

      const response = await fetch(dryFoodsUrl, {
        headers: {
          "X-CSRF-Token": this.csrfToken,
          "Accept": "application/json"
        }
      });
      const data = await response.json();

      const filteredFoods = data.filter(dry => {
        return dry.food_type === type;
      });

      if (filteredFoods.length === 0) {
        const selectedText = this.foodTypeTarget.options[this.foodTypeTarget.selectedIndex].text;
        const message = I18n.t('trackers.form.no_storage_message', { type: selectedText });
        alert(message);
        const newDryFoodUrl = `/${locale}/dry_foods/new`;
        window.location.href = newDryFoodUrl;
      } else {
        this.updateDryFoodOptions(filteredFoods);
      }
    } else if (type === "wet") {
      if (this.hasWetFoodOptionsTarget) this.wetFoodOptionsTarget.classList.remove("hidden");
      if (this.hasDryFoodOptionsTarget) this.dryFoodOptionsTarget.classList.add("hidden");

      if (pathParts.length > 3) {
        const petId = pathParts[3];
        const favoriteFoodsUrl = `/${locale}/pets/${petId}/trackers/favorite_food.json`

        const response = await fetch(favoriteFoodsUrl, {
          headers: {
            "X-CSRF-Token": this.csrfToken,
            "Accept": "application/json"
          }
        });
        const data = await response.json();
        
        this.updateWetFoodOptions(data);
      }
    } else {
      if (this.hasDryFoodOptionsTarget) this.dryFoodOptionsTarget.classList.add("hidden");
      if (this.hasWetFoodOptionsTarget) this.wetFoodOptionsTarget.classList.add("hidden");
    }
  }

  updateDryFoodOptions(foods) {
    if (!this.hasDryFoodSelectTarget) return;
    this.dryFoodSelectTarget.innerHTML = `<option value="">${I18n.t('trackers.form.select_dry_food')}</option>`;
    foods.forEach(food => {
      const option = document.createElement("option");
      option.value = food.id;
      const leftAmountText = I18n.t('javascript.tracker_form_controller.left_in_storage', { amount: food.left_amount });

      if (food.left_amount < food.amount * 10/100) {
        const restockText = I18n.t('javascript.tracker_form_controller.should_restock');
        option.text = `⚠️ ${food.brand} - ${food.description} (${leftAmountText}, ${restockText})`;
      } else {
        option.text = `${food.brand} - ${food.description} (${leftAmountText})`;
      }
      this.dryFoodSelectTarget.add(option);
    });
  }

  updateWetFoodOptions(foods) {
    if (!this.hasWetFoodSelectTarget) return;
    this.wetFoodSelectTarget.innerHTML = `<option value="">${I18n.t('javascript.tracker_form_controller.select_wet_food')}</option>`;
    if (!Array.isArray(foods)) {
      return;
    }

    const today = new Date();
    let thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(today.getDate() - 30);

    const filteredFood = foods.map(food => {
      if (!food || food.food_type !== "wet" || !food.results || food.results.length === 0) {
        return null;
      }

      const filteredResults = food.results.filter(result => {
        const dateParts = result.date.split('/');
        if (dateParts.length !== 3) {
          return false;
        }

        const year = parseInt(dateParts[0], 10);
        const month = parseInt(dateParts[1], 10) - 1;
        const day = parseInt(dateParts[2], 10);
        const foodDate = new Date(year, month, day);
      
        return foodDate >= thirtyDaysAgo && foodDate <= today;
      });

      if (filteredResults.length > 0) {
        return { ...food, results: filteredResults };
      }
      return null;
    }).filter(food => food !== null);

    filteredFood.forEach(food => {
      const option = document.createElement('option');
      option.value = food.results[0].id;
      if (food.results[0].favorite_score >= 30) {
        option.text = `${food.brand} ${food.description}: ${I18n.t('javascript.tracker_form_controller.favorite_score')} ${food.results[0].favorite_score} - ${I18n.t('javascript.tracker_form_controller.last_feed_date')} ${food.results[0].date}`;
        this.wetFoodSelectTarget.add(option);
      }
    });
  }

  async fillDryFoodFields() {
    if (!this.hasDryFoodSelectTarget) return;
    const foodId = this.dryFoodSelectTarget.value;

    if (foodId) {
      try {
        const locale = document.documentElement.lang || 'en';
        const url = `/${locale}/dry_foods/${foodId}.json`;
        const response = await fetch(url, {
          headers: {
            "X-CSRF-Token": this.csrfToken,
            "Accept": "application/json"
          }
        });

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        if (this.hasBrandTarget) this.brandTarget.value = data.brand;
        if (this.hasDescriptionTarget) this.descriptionTarget.value = data.description;
        this.selectedFoodLeftAmount = data.left_amount;
        this.validateAmount()
      } catch (error) {
        console.error("Error fetching dry food data:", error);
      }
    }
    this.validateAmount();
  }

  async fillWetFoodFields() {
    if (!this.hasWetFoodSelectTarget) return;
    const foodId = this.wetFoodSelectTarget.value;

    if (foodId) {
      try {
        const locale = document.documentElement.lang || 'en';
        const petId = window.location.pathname.split('/')[3];
        const url = `/${locale}/pets/${petId}/trackers/${foodId}.json`
        const response = await fetch(url, {
          headers: {
            "X-CSRF-Token": this.csrfToken,
            "Accept": "application/json"
          }
        });

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        if (this.hasBrandTarget) this.brandTarget.value = data.brand;
        if (this.hasDescriptionTarget) this.descriptionTarget.value = data.description;
        if (this.hasAmountTarget) this.amountTarget.value = data.amount;
      } catch (error) {
        console.error("Error fetching wet food data:", error);
      }
    }
  }

  validateAmount() {
    if (!this.hasAmountTarget) return;
    const inputAmount = parseFloat(this.amountTarget.value);

    if (this.selectedFoodLeftAmount != null && !isNaN(inputAmount)) {
      if (inputAmount > this.selectedFoodLeftAmount) {
        if (this.hasAmountAlertTarget) {
          this.amountAlertTarget.textContent = I18n.t('javascript.tracker_form_controller.only_left_in_storage', { amount: this.selectedFoodLeftAmount });
          this.amountAlertTarget.classList.remove('hidden');
          this.amountAlertTarget.classList.replace("text-green-500", "text-red-500");
        }
        if (this.hasSubmitButtonTarget) {
          this.submitButtonTarget.disabled = true;
          this.submitButtonTarget.classList.remove("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
          this.submitButtonTarget.classList.add("bg-gray-400", "cursor-not-allowed");
        }
      } else {
        if (this.hasAmountAlertTarget) {
          this.amountAlertTarget.textContent = I18n.t('javascript.tracker_form_controller.is_valid_amount', { amount: inputAmount });
          this.amountAlertTarget.classList.remove('hidden');
          this.amountAlertTarget.classList.replace("text-red-500", "text-green-500");
        }
        if (this.hasSubmitButtonTarget) {
          this.submitButtonTarget.disabled = false;
          this.submitButtonTarget.classList.add("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
          this.submitButtonTarget.classList.remove("bg-gray-400", "cursor-not-allowed");
        }
      }
    } else {
      this.hideAlert();
    }
  }

  hideAlert() {
    if (this.hasAmountAlertTarget) {
      this.amountAlertTarget.textContent = "";
      this.amountAlertTarget.classList.add("hidden");
    }
  }
}
