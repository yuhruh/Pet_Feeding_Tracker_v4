import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["foodType", "dryFoodOptions", "dryFoodSelect", "wetFoodOptions", "wetFoodSelect", "brand", "description", "amount", "amountAlert", "submitButton", "discardLeftoverOption", "discardLeftover", "lastLeftoverOption", "lastLeftoverLabel", "lastLeftover"]
  static values = {
    dryFoods: Array,
    trackerUrl: String,
    newDryFoodUrl: String,
    // Bag id => this cat's last feeding from it, whose leftover may still be in
    // the bowl: { amount, left_amount (null if not recorded), discarded, when }.
    lastFeedings: Object
  }

  connect() {
    this.csrfToken = document.querySelector("meta[name='csrf-token']")?.content;
    this.selectedFoodLeftAmount = null; // Initialize storage state
    this.lastFeeding = null;
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
      this.hideDryFoodOptions();

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
      this.hideDryFoodOptions();
      if (this.hasWetFoodOptionsTarget) this.wetFoodOptionsTarget.classList.add("hidden");
    }
  }

  // A hidden bag picker still submits its value, so clear it too: otherwise a
  // wet or other feeding would draw from the bag picked before the switch.
  hideDryFoodOptions() {
    if (this.hasDryFoodOptionsTarget) this.dryFoodOptionsTarget.classList.add("hidden");
    if (this.hasDryFoodSelectTarget) this.dryFoodSelectTarget.value = "";
    this.selectedFoodLeftAmount = null;
    this.selectLastFeeding(null);
  }

  // The cat's last feeding from the picked bag. When its leftover was never
  // recorded, the form asks for it here, since the new feeding tops it up.
  selectLastFeeding(foodId) {
    this.lastFeeding = (foodId && this.lastFeedingsValue[foodId]) || null;
    const last = this.lastFeeding;
    const askLeftover = last != null && last.left_amount == null && !last.discarded;

    if (this.hasLastLeftoverOptionTarget) {
      this.lastLeftoverOptionTarget.classList.toggle("hidden", !askLeftover);
    }
    if (this.hasLastLeftoverTarget) {
      if (askLeftover) {
        this.lastLeftoverTarget.max = last.amount;
      } else {
        this.lastLeftoverTarget.value = "";
      }
    }
    if (askLeftover && this.hasLastLeftoverLabelTarget) {
      this.lastLeftoverLabelTarget.textContent = I18n.t('javascript.tracker_form_controller.last_feeding_leftover', { when: last.when, amount: last.amount });
    }
  }

  // Grams still in the bowl from the last feeding: recorded, or entered here.
  enteredBowlLeftover() {
    const last = this.lastFeeding;
    if (!last || last.discarded) return 0;
    if (last.left_amount != null) return last.left_amount;
    const entered = this.hasLastLeftoverTarget ? parseFloat(this.lastLeftoverTarget.value) : NaN;
    return isNaN(entered) ? 0 : entered;
  }

  // Offer "threw it away" only when the bowl still holds a leftover to top up.
  toggleDiscardLeftoverOption() {
    if (!this.hasDiscardLeftoverOptionTarget) return;
    const show = this.enteredBowlLeftover() > 0;
    this.discardLeftoverOptionTarget.classList.toggle("hidden", !show);
    if (!show && this.hasDiscardLeftoverTarget) this.discardLeftoverTarget.checked = false;
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
        this.selectedFoodLeftAmount = parseFloat(data.left_amount);
        this.selectLastFeeding(foodId);
        this.validateAmount()
      } catch (error) {
        console.error("Error fetching dry food data:", error);
      }
    } else {
      this.selectedFoodLeftAmount = null;
      this.selectLastFeeding(null);
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
    this.toggleDiscardLeftoverOption();
    if (!this.hasAmountTarget) return;
    const inputAmount = parseFloat(this.amountTarget.value);
    const last = this.lastFeeding;
    const bowlLeftover = this.enteredBowlLeftover();

    if (last && bowlLeftover > last.amount) {
      this.showAmountAlert(I18n.t('javascript.tracker_form_controller.last_leftover_too_much', { amount: last.amount }), false);
      return;
    }
    if (this.selectedFoodLeftAmount == null || isNaN(inputAmount)) {
      this.hideAlert();
      this.setSubmitEnabled(true);
      return;
    }

    // The bowl still holds the last feeding's leftover, so this feeding only
    // takes the top-up from the bag, the same as the server counts it.
    // Thrown away instead, the feeding takes its full amount.
    const discarded = this.hasDiscardLeftoverTarget && this.discardLeftoverTarget.checked;
    const bowl = discarded ? 0 : bowlLeftover;
    const drawn = Math.max(Math.round((inputAmount - bowl) * 100) / 100, 0);

    if (drawn > this.selectedFoodLeftAmount) {
      this.showAmountAlert(I18n.t('javascript.tracker_form_controller.only_left_in_storage', { amount: this.selectedFoodLeftAmount }), false);
    } else if (bowl > 0) {
      this.showAmountAlert(I18n.t('javascript.tracker_form_controller.topped_up_amount', { bowl: bowl, drawn: drawn }), true);
    } else {
      this.showAmountAlert(I18n.t('javascript.tracker_form_controller.is_valid_amount', { amount: inputAmount }), true);
    }
  }

  showAmountAlert(text, ok) {
    if (this.hasAmountAlertTarget) {
      this.amountAlertTarget.textContent = text;
      this.amountAlertTarget.classList.remove("hidden");
      if (ok) {
        this.amountAlertTarget.classList.replace("text-red-500", "text-green-500");
      } else {
        this.amountAlertTarget.classList.replace("text-green-500", "text-red-500");
      }
    }
    this.setSubmitEnabled(ok);
  }

  setSubmitEnabled(enabled) {
    if (!this.hasSubmitButtonTarget) return;
    const on = ["bg-softBlue", "hover:bg-white", "hover:text-softBlue", "hover:border-softBlue", "cursor-pointer"];
    const off = ["bg-gray-400", "cursor-not-allowed"];
    this.submitButtonTarget.disabled = !enabled;
    this.submitButtonTarget.classList.remove(...(enabled ? off : on));
    this.submitButtonTarget.classList.add(...(enabled ? on : off));
  }

  hideAlert() {
    if (this.hasAmountAlertTarget) {
      this.amountAlertTarget.textContent = "";
      this.amountAlertTarget.classList.add("hidden");
    }
  }
}
