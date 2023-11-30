import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-meal-form"
export default class extends Controller {
  static targets = ["card", "amount"]
  connect() {
    console.log("Hello there");
  }

  select(event) {
    console.log("event.target", event.target.tagName);

    if (event.target.tagName !== "I" && event.target.tagName !== "INPUT") {
      event.currentTarget.classList.toggle("selected");
      if (event.currentTarget.classList.contains("selected")) {
        event.currentTarget.querySelector("input").autofocus = true;
      }
    }

    if (!event.currentTarget.classList.contains("selected")) {
      this.amountTarget.value = "";
    }
  }

  add() {
    this.element.classList.add("selected");
  }
}
