import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["foodType", "dryFoodOptions", "dryFoodSelect", "brand", "description", "amount", "amountAlert"]
  static values = { dryFoods: Array }

  connect() {
    this.toggleDryFoodOptions()
  }

  toggleDryFoodOptions() {
    const type = this.foodTypeTarget.value
    console.log(type)
  }
}