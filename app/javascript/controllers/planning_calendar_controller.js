import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="planning-calendar"
export default class extends Controller {
  static targets = ['form']
  connect() {
    console.log("connected")
  }
  show(event){
    this.formTarget.classList.remove("d-none")
    const date = event.currentTarget.getAttribute("data-value")
    document.querySelector("#planning_date").setAttribute("value", date)
  }

  hide(){
    this.formTarget.classList.add("d-none")
  }

  submit(event){
    event.preventDefault
  }
}
