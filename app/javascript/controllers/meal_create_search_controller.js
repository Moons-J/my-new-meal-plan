import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-create-search"
export default class extends Controller {
  static targets = ["input", "ingredient", "card"]

  connect() {
  }

  search(event) {
    // console.log(event.currentTarget.value);
    const query = event.currentTarget.value
    console.log(query);
    this.ingredientTargets.forEach(ingredient => {
      console.log(ingredient.innerText.includes(query));
      if (!ingredient.innerText.includes(query)) {
        this.cardTarget.classList.remove("d-none")
      } else {
        this.cardTarget.classList.add("d-none")
      }
    });
  }
}
