import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-nutrition-chart"
export default class extends Controller {
  static targets = [ "nutritionNum" ];
  static values = {
    userMax: Number,
   }

  connect() {
    // this.update();
  }

  update() {
    console.log("update");
    this.nutritionNumTarget.style.setProperty('--p', `${this.#percentage()}`);
  }

  #percentage() {
    const percentage = (parseFloat(this.nutritionNumTarget.innerText) / this.userMaxValue) * 100;
    return Math.round(percentage);
  }
}
