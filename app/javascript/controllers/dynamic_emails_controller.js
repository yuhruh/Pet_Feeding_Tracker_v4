import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container" ]

  add(event) {
    event.preventDefault()
    
    // Create a new wrapper div
    const wrapper = document.createElement("div")
    wrapper.className = "flex items-center space-x-2 mb-2 email-input-wrapper"
    
    // Create the input field
    const input = document.createElement("input")
    input.type = "email"
    input.name = "vet_visit[member_emails][]"
    input.placeholder = "member@example.com"
    input.className = "w-full border-2 border-gray-300 rounded-lg p-2 focus:ring-amber-500 focus:border-amber-500 dark:bg-gray-800"
    
    // Create the remove button
    const removeBtn = document.createElement("button")
    removeBtn.type = "button"
    removeBtn.className = "px-3 py-2 bg-red-500 hover:bg-red-600 text-white rounded-lg font-bold"
    removeBtn.innerText = "✕"
    removeBtn.dataset.action = "click->dynamic-emails#remove"
    
    wrapper.appendChild(input)
    wrapper.appendChild(removeBtn)
    
    this.containerTarget.appendChild(wrapper)
  }

  remove(event) {
    event.preventDefault()
    const wrapper = event.target.closest(".email-input-wrapper")
    if (wrapper) {
      wrapper.remove()
    }
  }
}
