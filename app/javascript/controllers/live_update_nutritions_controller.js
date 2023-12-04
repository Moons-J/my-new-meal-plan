import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="live-update-nutritions"
export default class extends Controller {
  static targets = [ "calories", "fats", "satuFats", "carbs", "protein", "mealCard" ]
  connect() {
  }

  update(){
    let totalCalories = 0;
    let totalFats = 0;
    let totalSatuFats = 0;
    let totalCarbs = 0;
    let totalProtein = 0;
    this.mealCardTargets.forEach((card) => {
      if (card.classList.contains("selected")) {
        totalCalories += parseInt(card.querySelector("#calories").innerText)
        totalFats += parseFloat(card.querySelector("#fats").innerText)
        totalSatuFats += parseFloat(card.querySelector("#satu-fats").innerText)
        totalCarbs += parseFloat(card.querySelector("#carbs").innerText)
        totalProtein += parseFloat(card.querySelector("#protein").innerText)
      };
    });
    this.caloriesTarget.innerText = totalCalories;
    this.fatsTarget.innerText = Math.round(totalFats * 10) / 10;
    this.satuFatsTarget.innerText = Math.round(totalSatuFats * 10) / 10;
    this.carbsTarget.innerText = Math.round(totalCarbs * 10) / 10;;
    this.proteinTarget.innerText = Math.round(totalProtein * 10) / 10;;
  }

  image(event) {
    // this.element.querySelector(".picture-show").appendChild(event.target.files[0]);
    // <img src="" alt="" class="picture-show"></img>
    this.element.querySelector(".picture-preview").innerHTML = '';
    this.element.querySelector(".drop-title").innerText = "Edit image"
    this.element.querySelector(".picture-preview").insertAdjacentHTML("beforeend", `<img src="${URL.createObjectURL(event.target.files[0])}" alt="" class="picture-show"></img>`);
    console.log(URL.createObjectURL(event.target.files[0]));
  }
}
