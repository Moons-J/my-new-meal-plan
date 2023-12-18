import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="planning-calendar"
export default class extends Controller {
  static targets = ['form']

  connect() {
  }
  show(event){
    this.formTarget.classList.remove("d-none")
    const date = event.currentTarget.getAttribute("data-value")
    document.querySelector("#planning_date").setAttribute("value", date)
    if (event.currentTarget.querySelector("i")) {
      const planId = event.currentTarget.querySelector("i").getAttribute("data-plan-id")
      fetch(`/daily_plans?p=${planId}`, { headers: { "Accept": "text/plain" } })
        .then(response => response.text())
        .then(data => {
          console.log(this.formTarget)
          this.formTarget.innerHTML = data
        })
    }
  }

  hide(){
    this.formTarget.classList.add("d-none")
  }

  submit(event){
    event.preventDefault
  }
}
