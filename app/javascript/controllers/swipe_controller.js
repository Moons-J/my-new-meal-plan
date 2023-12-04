import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swipe"
export default class extends Controller {
  static targets = ['card', 'button']

  connect() {
    this.startX = 0;
    this.endX = 0;
    // document.addEventListener("touchstart", this.swipeCard.bind(this))
    // document.addEventListener("touchend", this.stopSwipeCard.bind(this))
  }
  swipeCard(event) {
    this.startX = event.touches[0].clientX;
  }
  stopSwipeCard(event){
    this.endX = event.changedTouches[0].clientX;
    this.handleSwipe();
  }
  handleSwipe(){
    const swipeDistance = this.endX - this.startX;
    const width = this.cardTarget.offsetWidth
    const height = this.cardTarget.offsetHeight
    if (swipeDistance < -50) {
      this.cardTarget.classList.add("deletingCard")
      this.cardTarget.style.width = `${width}px`
      this.cardTarget.style.height = `${height}px`
      setTimeout(() => {this.buttonTarget.classList.remove("hidden")}, 330)
      // this.buttonTarget.classList.remove("hidden")
    } else {
      this.cardTarget.classList.remove("deletingCard")
      this.buttonTarget.classList.add("hidden")
    }
  }
}
