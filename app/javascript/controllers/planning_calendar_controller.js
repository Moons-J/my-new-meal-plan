import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="planning-calendar"
export default class extends Controller {
  static targets = ['date', 'form']
  connect() {
    console.log("connected")
  }
  show(event){
    console.log(event.target)
    this.formTarget.classList.toggle("d-none")
    const date = event.target.getAttribute("data-value")
    document.querySelector("#planning_date").setAttribute("value", date)
  }
  hide(){
    this.formTarget.classList.add("d-none")
  }

  submit(event){
    event.preventDefault
    console.log("submitting")
  }
}
