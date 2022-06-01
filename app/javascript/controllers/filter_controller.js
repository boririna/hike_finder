import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["text", "form"];

  displayForm() {
    this.textTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }

  hideForm() {
    this.textTarget.classList.remove("d-none")
    this.formTarget.classList.add("d-none")
  }

}
