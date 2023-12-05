import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="adding-delete-section-to-daily-plan"
export default class extends Controller {
  static targets = [ "form" ]
  static values = { template: String }
  connect() {
    this.regex = /(\d+)/;
    this.template = document.getElementById("template").content;
    const id = parseInt(this.template.querySelector(".meal_id").name.match(this.regex)[0]);
    this.currentId = id;
  }

  addSection(event){
    event.preventDefault();
    const sectionClone = this.template.cloneNode(true);
    const input = sectionClone.querySelector(".meal_id");
    const label = sectionClone.querySelector(".meal_type_name");
    input.setAttribute("name", input.name.replace(this.regex, this.currentId));
    label.setAttribute("name", label.name.replace(this.regex, this.currentId));
    this.currentId += 1;
    this.formTarget.appendChild(sectionClone);
    this.formTarget.lastElementChild.scrollIntoView({ behavior: "smooth", block: "center", inline: "center" });
  }
}
