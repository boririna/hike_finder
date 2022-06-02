import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["text", "review", "image", "imagetext"];

  displayForm() {
    this.textTarget.classList.add("d-none")
    this.reviewTarget.classList.remove("d-none")
  }

  hideForm() {
    this.textTarget.classList.remove("d-none")
    this.reviewTarget.classList.add("d-none")
  }

  displayImage() {
    this.imagetextTarget.classList.add("d-none")
    this.imageTarget.classList.remove("d-none")
  }

  hideImage() {
    this.imagetextTarget.classList.remove("d-none")
    this.imageTarget.classList.add("d-none")
  }

}
