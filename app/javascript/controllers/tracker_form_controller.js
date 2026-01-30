import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["foodType", "dryFoodOptions", "dryFoodSelect", "brand", "description", "amount", "amountAlert"]
  static values = { dryFoods: Array }

  connect() {
    this.toggleDryFoodOptions()
  }

  async toggleDryFoodOptions() {
    const type = this.foodTypeTarget.value
    if (type === "Kibble" || type === "Freeze-Dried") {
      this.dryFoodOptionsTarget.classList.remove("hidden");

      const csrfToken = document.querySelector("meta[name='csrf-token']").content;
      const response = await fetch(`/dry_foods`, {
        headers: {
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json"
        }
      })
      const data = await response.json()
      const filteredFoods = data.filter(dry => dry.food_type === type);

      this.updateDryFoodOptions(filteredFoods);

    } else {
      this.dryFoodOptionsTarget.classList.add("hidden");
    }
  }

  updateDryFoodOptions(foods) {
    this.dryFoodSelectTarget.innerHTML = `<option value="">Select A Dry Food</option>`;
    foods.forEach(food => {
      const option = document.createElement("option");
      option.value = food.id;
      option.text = `${food.brand} - ${food.description}`;
      this.dryFoodSelectTarget.add(option);
    });
  }
}
