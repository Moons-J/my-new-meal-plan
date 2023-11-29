import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swipe-delete"
export default class extends Controller {
  static targets = ["meal"]
  connect() {
    console.log("working")
    this.boundDeleteCard = this.deleteCard.bind(this)
    document.addEventListener("touchmove", this.boundDeleteCard);
  }
  deleteCard(){
    console.log("Reading")
    console.log(this.mealTarget)
  }
}
