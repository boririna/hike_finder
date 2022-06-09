import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["text", "form", "length", "altitude", "lengthLabel", "altitudeLabel"];

  displayForm() {
    this.textTarget.classList.add("d-none")
    this.formTarget.classList.remove("d-none")
  }

  hideForm() {
    this.textTarget.classList.remove("d-none")
    this.formTarget.classList.add("d-none")
  }

  updateLength(e) {
    this.lengthTarget.value = e.target.value
    this.lengthLabelTarget.innerHTML = "Length: " + e.target.value +" km"
  }

  updateAltitude(e) {
    this.altitudeTarget.value = e.target.value
    this.altitudeLabelTarget.innerHTML = "Altitude gain: " + e.target.value +" m"
  }

}
