import { Controller } from "@hotwired/stimulus";
import { I18n } from "i18n-js";
import translations from "translations";

export default class extends Controller {
  static targets = ["foodType", "dryFoodOptions", "dryFoodSelect", "wetFoodOptions", "wetFoodSelect", "brand", "description", "amount", "amountAlert", "submitButton"]
  static values = {
    dryFoods: Array,
    trackerUrl: String,
    newDryFoodUrl: String
  }

  connect() {
    this.csrfToken = document.querySelector("meta[name='csrf-token']").content;
    // initialize with imported translatios object
    const i18n = new I18n(translations);
    this.i18n = i18n;
    // set the locale
    this.i18n.locale = document.documentElement.lang || "en";    

    this.selectedFoodLeftAmount = null; // Initialize storage state
    this.toggleDryFoodOptions()
  }

  async toggleDryFoodOptions() {
    const type = this.foodTypeTarget.value;
    const locale = window.location.pathname.split('/')[1] || 'en';
    const dryFoodsUrl = `/${locale}/dry_foods.json`;

    if (type === "kibble" || type === "freeze_dried") {
      this.dryFoodOptionsTarget.classList.remove("hidden");

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
        const message = this.i18n.t('trackers.form.no_storage_message', { type: selectedText });
        alert(message);
        const locale = window.location.pathname.split('/')[1] || 'en';
        const newDryFoodUrl = `/${locale}/dry_foods/new`;
        window.location.href = newDryFoodUrl;
      } else {
        this.updateDryFoodOptions(filteredFoods);
      }
    } else if (type === "wet") {
      this.wetFoodOptionsTarget.classList.remove("hidden");
      this.dryFoodOptionsTarget.classList.add("hidden");

      const petId = window.location.pathname.split('/')[3];
      const favoriteFoodsUrl = `/${locale}/pets/${petId}/trackers/favorite_food.json`

      const response = await fetch(favoriteFoodsUrl, {
        headers: {
          "X-CSRF-Token": this.csrfToken,
          "Accept": "application/json"
        }
      });
      const data = await response.json();
      this.updateWetFoodOptions(data);
    } else {
      this.dryFoodOptionsTarget.classList.add("hidden");
      this.wetFoodOptionsTarget.classList.add("hidden");
    }
  }

  updateDryFoodOptions(foods) {
    this.dryFoodSelectTarget.innerHTML = `<option value="">${this.i18n.t('trackers.form.select_dry_food')}</option>`;
    foods.forEach(food => {
      const option = document.createElement("option");
      option.value = food.id;
      const leftAmountText = this.i18n.t('javascript.tracker_form_controller.left_in_storage', { amount: food.left_amount });

      if (food.left_amount < food.amount * 10/100) {
        const restockText = this.i18n.t('javascript.tracker_form_controller.should_restock');
        option.text = `⚠️ ${food.brand} - ${food.description} (${leftAmountText}, ${restockText})`;
      } else {
        option.text = `${food.brand} - ${food.description} (${leftAmountText})`;
      }
      this.dryFoodSelectTarget.add(option);
    });
  }

  updateWetFoodOptions(foods) {
    this.wetFoodSelectTarget.innerHTML = `<option value="">${this.i18n.t('trackers.form.select_favorite_or_enter_manually')}</option>`;
    const filteredFood = foods.filter(food => food.food_type === "wet")
    filteredFood.forEach(food => {
      const option = document.createElement('option');
      option.value = food.id;
      option.text = `${food.brand} ${food.description}: Favorite Score: ${food.favorite_score} - Last Feed Date: ${food.date}`;
      this.wetFoodSelectTarget.add(option);
    })

  }

  async fillDryFoodFields() {
    const foodId = this.dryFoodSelectTarget.value;

    if (foodId) {
      try {
        const locale = window.location.pathname.split('/')[1] || 'en';
        const url = `/${locale}/dry_foods/${foodId}.json`;
        const response = await fetch(url, {
          headers: {
            "X-CSRF-Token": this.csrfToken,
            "Accept": "application/json"
          }
        });

        if (!response.ok) {
          if (response.status === 406) {
            console.error("Not acceptable. Check API for JSON response.");
          }
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

  async fillWetFoodFields() {
    const foodId = this.wetFoodSelectTarget.value;

    if (foodId) {
      try {
        const locale = window.location.pathname.split('/')[1] || 'en';
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
        this.brandTarget.value = data.brand;
        this.descriptionTarget.value = data.description;
        this.amountTarget.value = data.amount;
      } catch (error) {
        console.error("Error fetching wet food data:", error);
        this.brandTarget.value = "";
        this.descriptionTarget.value = "";
        this.amountTarget.value = "";
      }
    } else {
      this.brandTarget.value = "";
      this.descriptionTarget.value = "";
      this.amountTarget.value = "";
    }
  }

  validateAmount() {
    const inputAmount = parseFloat(this.amountTarget.value);

    // only validate if we have a selected dry food and an input amount
    if (this.selectedFoodLeftAmount != null && !isNaN(inputAmount)) {
      if (inputAmount > this.selectedFoodLeftAmount) {
        this.amountAlertTarget.textContent = this.i18n.t('javascript.tracker_form_controller.only_left_in_storage', { amount: this.selectedFoodLeftAmount });
        this.amountAlertTarget.classList.remove('hidden');
        this.amountAlertTarget.classList.replace("text-green-500", "text-red-500");
        this.submitButtonTarget.disabled = true;
        this.submitButtonTarget.classList.remove("bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer");
        this.submitButtonTarget.classList.add("bg-gray-400", "cursor-not-allowed");
      } else {
        this.amountAlertTarget.textContent = this.i18n.t('javascript.tracker_form_controller.is_valid_amount', { amount: inputAmount });
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