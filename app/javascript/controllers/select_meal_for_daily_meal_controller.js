import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-meal-for-daily-meal"
export default class extends Controller {
  static targets = [ "card" ]
  connect() {
    console.log("Hello, Stimulus!")
  }

  select(event){
    this.cardTargets.forEach((card) => {
      if (card.classList.contains("selected")) {
        card.classList.remove("selected");
      };
    });
    event.currentTarget.classList.toggle("selected");
    console.log(this.cardTargets)
  }
}
