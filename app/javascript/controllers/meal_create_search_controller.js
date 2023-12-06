import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-create-search"
export default class extends Controller {
  static targets = ["input", "ingredient", "card"];

  connect() {
  }

  search(event) {
    const query = this.inputTarget.value.toLowerCase()
    this.cardTargets.forEach(card => {
      if (card.querySelector("h2").innerText.toLowerCase().includes(query)) {
        card.classList.remove("d-none")
      } else {
        card.classList.add("d-none")
      }
    });

  }

  image(event) {
    this.element.querySelector(".picture-preview").innerHTML = '';
    this.element.querySelector(".drop-title").innerText = "Edit image"
    this.element.querySelector(".picture-preview").insertAdjacentHTML("beforeend", `<img src="${URL.createObjectURL(event.target.files[0])}" alt="" class="picture-show"></img>`);
    console.log(URL.createObjectURL(event.target.files[0]));
  }
}
