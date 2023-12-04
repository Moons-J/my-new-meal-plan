import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-meal-form"
export default class extends Controller {
  static targets = ["card", "amount"]
  connect() {
  }

  select(event) {
    if (event.target.tagName !== "I" && event.target.tagName !== "INPUT") {
      event.currentTarget.classList.toggle("selected");
      this.validate()
    }

    // Update nutrition stats

    if (!event.currentTarget.classList.contains("selected")) {
      this.amountTarget.value = "";
    }
  }

  add() {
    this.element.classList.add("selected");
  }

  validate() {
    if (this.element.classList.contains("selected") && this.amountTarget.value == "") {
      this.amountTarget.classList.add("is-invalid")
    } else {
      this.amountTarget.classList.remove("is-invalid")
    }
  }

}
