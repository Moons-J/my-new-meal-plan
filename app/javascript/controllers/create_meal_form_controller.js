import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="create-meal-form"
export default class extends Controller {
  connect() {
    console.log("Hello there");
  }

  select() {
    console.log("clicked");
  }
}
