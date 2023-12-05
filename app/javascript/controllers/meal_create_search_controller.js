import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meal-create-search"
export default class extends Controller {
  static targets = ["input", "ingredient", "card", "list", "amount", "calloriesnum", "fatsnum", "satufatsnum", "carbsnum", "proteinnum"];

  connect() {
  }

  search(event) {
    const query = this.inputTarget.value.toLowerCase()

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

  // calculate() {
  //   if (this.cardTarget.classList.contains("selected") && !this.amountTarget.value==""){
  //     // select all where amount is not empty
  //     const ingredients = this.cardTargets.filter(card => !card.querySelector(".amount").value=="");
  //     // calculate nutritions
  //     let nutritions = {
  //       calories: 0,
  //       fats: 0,
  //       satufats: 0,
  //       carbs: 0,
  //       protein: 0
  //     }
  //     // console.log(ingredients);
  //     ingredients.forEach(ingredient => {
  //       // console.log(parseFloat(ingredient.dataset.fats));
  //       // console.log(parseFloat(ingredient.dataset.satufats ));
  //       // console.log(parseFloat(ingredient.dataset.carbs ));
  //       // console.log(parseFloat(ingredient.dataset.protein ));
  //       // console.log(ingredient.querySelector(".amount").value);
  //       let amount = parseInt(ingredient.querySelector(".amount").value)
  //       nutritions.calories += parseInt(ingredient.dataset.callories) / 100 * amount;
  //       nutritions.fats += parseFloat(ingredient.dataset.fats) / 100 * amount;
  //       nutritions.satufats += parseFloat(ingredient.dataset.satufats) / 100 * amount;
  //       nutritions.carbs += parseFloat(ingredient.dataset.carbs) / 100 * amount;
  //       nutritions.protein += parseFloat(ingredient.dataset.protein) / 100 * amount;
  //     });
  //     // display nutritions
  //     this.calloriesnumTarget.innerText = nutritions.calories;
  //     this.fatsnumTarget.innerText = Math.round(nutritions.fats * 10) / 10;
  //     this.satufatsnumTarget.innerText = Math.round(nutritions.satufats * 10) / 10;
  //     this.carbsnumTarget.innerText = Math.round(nutritions.carbs * 10) / 10;
  //     this.proteinnumTarget.innerText = Math.round(nutritions.protein * 10) / 10;
  //   }
  // }

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
    this.element.querySelector(".drop-title").innerText = "Edit image"
    this.element.querySelector(".picture-preview").insertAdjacentHTML("beforeend", `<img src="${URL.createObjectURL(event.target.files[0])}" alt="" class="picture-show"></img>`);
    console.log(URL.createObjectURL(event.target.files[0]));
  }
}
