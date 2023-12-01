import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-create-search"
export default class extends Controller {
  static targets = ["input", "ingredient", "card", "list"];

  connect() {
  }

  search(event) {
    const query = this.inputTarget.value.toLowerCase()
    console.log(query);
    // if (query == "") {
    //   this.sort()
    // }

    this.cardTargets.forEach(card => {
      if (card.querySelector("h2").innerText.toLowerCase().includes(query)) {
        card.classList.remove("d-none")
      } else {
        card.classList.add("d-none")
      }
    });

  }

  // sort() {
  //   let list = Array.from(this.cardTargets);
  //   list.sort((a, b)=> {
  //     if (a.classList.contains("selected")) {
  //       return -1
  //     } else {
  //       return 1
  //     }
  //   })
  //   list.forEach(element => {
  //     this.listTarget.appendChild(element);
  //   });
  // }

  image(event) {
    // this.element.querySelector(".picture-show").appendChild(event.target.files[0]);
    // <img src="" alt="" class="picture-show"></img>
    this.element.querySelector(".picture-preview").innerHTML = '';
    this.element.querySelector(".picture-preview").insertAdjacentHTML("beforeend", `<img src="${URL.createObjectURL(event.target.files[0])}" alt="" class="picture-show"></img>`);
    console.log(URL.createObjectURL(event.target.files[0]));
  }
}
