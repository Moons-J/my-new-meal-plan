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
    // console.log(event.currentTarget.dataset.mealid);
    this.inputTarget.value = event.currentTarget.dataset.mealid;
  }
}
