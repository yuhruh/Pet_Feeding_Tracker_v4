import { Controller } from "@hotwired/stimulus"

// Feeding details: the food type decides which suggestions are offered (the
// household's bags, the cat's favorite wet foods, its past "other" foods).
// Picking one fills in brand and description; typing something new is fine.
export default class extends Controller {
  static targets = ["foodType", "suggestionsField", "suggestions", "brand", "description", "dryFood"]
  static values = { options: Object }

  connect() {
    this.refresh()
  }

  refresh() {
    const list = this.optionsValue[this.foodTypeTarget.value] || []
    const select = this.suggestionsTarget
    select.replaceChildren(new Option(select.dataset.placeholder, ""))
    list.forEach((item, index) => select.add(new Option(item.label, index)))
    this.suggestionsFieldTarget.classList.toggle("hidden", list.length === 0)
    if (!["kibble", "freeze_dried"].includes(this.foodTypeTarget.value)) this.dryFoodTarget.value = ""
  }

  pick() {
    const item = (this.optionsValue[this.foodTypeTarget.value] || [])[this.suggestionsTarget.value]
    if (!item) return
    this.brandTarget.value = item.brand || ""
    this.descriptionTarget.value = item.description || ""
    this.dryFoodTarget.value = item.dry_food_id || ""
  }

  // A brand or description typed by hand isn't a bag any more.
  typed() {
    this.dryFoodTarget.value = ""
  }
}
