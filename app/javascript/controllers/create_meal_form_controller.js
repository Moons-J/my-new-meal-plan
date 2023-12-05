import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-meal-form"
export default class extends Controller {
  static targets = ["card", "amount", "list", "ingredientsList"]
  connect() {
    this.regex = /(\d+)/;
    // select last input and get index with regex
    const lastInput =this.element.querySelector('.meal-ingredients > div:last-of-type input[type="hidden"]');
    if (lastInput) {
      this.lastInputIndex = lastInput.name.match(this.regex)[0];
    } else {
      this.lastInputIndex = 0;
    }
  }

  delete(event) {
    if (event.target.tagName == "I") {
      const ingredientId = event.currentTarget.querySelector("input[type='hidden']").value;
      event.currentTarget.remove();
      console.log(this.ingredientsListTarget.querySelector(`#ingredient_${ingredientId}`).classList.remove("hide-from-ingredient-list"));
    }
  }

  insert(event) {
    if (event.target.tagName == "I") {
      const template = document.querySelector("template");
      const clone = template.content.cloneNode(true);
      clone.querySelector(".ingredient-card").dataset.callories = event.currentTarget.dataset.callories;
      clone.querySelector(".ingredient-card").dataset.fats = event.currentTarget.dataset.fats;
      clone.querySelector(".ingredient-card").dataset.satufats = event.currentTarget.dataset.satufats;
      clone.querySelector(".ingredient-card").dataset.carbs = event.currentTarget.dataset.carbs;
      clone.querySelector(".ingredient-card").dataset.protein = event.currentTarget.dataset.protein;
      clone.querySelector(".ingredient-card").querySelector("h2").innerText = event.currentTarget.querySelector("h2").innerText;
      clone.querySelector(".ingredient-id").value = event.currentTarget.querySelector(".ingredient-id").value;
      clone.querySelector("input[type='hidden']").name = `meal[meal_ingredients_attributes][${this.lastInputIndex + 1}][ingredient_id]`;
      clone.querySelector("input[type='hidden']").id = `meal_meal_ingredients_attributes_${this.lastInputIndex + 1}_ingredient_id`;
      clone.querySelector("input.amount").name = `meal[meal_ingredients_attributes][${this.lastInputIndex + 1}][amount]`;
      clone.querySelector("input.amount").id = `meal_meal_ingredients_attributes_${this.lastInputIndex + 1}_amount`;
      this.lastInputIndex += 1;
      this.listTarget.appendChild(clone);
      event.currentTarget.classList.add("hide-from-ingredient-list");
      console.log(event.currentTarget);
    }
  }

  // select(event) {
  //   if (event.target.tagName !== "I" && event.target.tagName !== "INPUT") {
  //     event.currentTarget.classList.toggle("selected");
  //     this.validate()
  //   }

  //   // Update nutrition stats

  //   if (!event.currentTarget.classList.contains("selected")) {
  //     this.amountTarget.value = "";
  //   }
  // }

  // add() {
  //   this.element.classList.add("selected");
  // }

  // validate() {
  //   if (this.element.classList.contains("selected") && this.amountTarget.value == "") {
  //     this.amountTarget.classList.add("is-invalid")
  //   } else {
  //     this.amountTarget.classList.remove("is-invalid")
  //   }
  // }

}
