import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check-item"
export default class extends Controller {
  static targets = ['item', 'checkbox']

  connect() {
  }

  check() {
    this.checkboxTarget.disabled = true;
    this.itemTarget.classList.add("text-decoration-line-through");
  }
}
