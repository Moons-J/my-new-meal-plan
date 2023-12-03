import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-meal-for-daily-meal"
export default class extends Controller {
  static targets = [ "card", "input" ]
  connect() {
  }

  select(event){
    this.cardTargets.forEach((card) => {
      if (card.classList.contains("selected")) {
        card.classList.remove("selected");
      };
    });
    event.currentTarget.classList.toggle("selected");
    this.inputTarget.value = event.currentTarget.dataset.mealid;

    // Custom event we will use as our trigger
    const trigger = new CustomEvent("trigger-nutrition-update");
    window.dispatchEvent(trigger);
  }
}
