import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]
  static values = {latitude: Number, longitude: Number}

  connect() {
    this.lat = this.latitudeValue
    this.long = this.longitudeValue
    console.log(typeof this.latitudeValue)
    console.log(this.latitudeValue)
    this.fetchData()
  }

  fetchData = async function() {
    const API_key="d5e4eb421780ca8fa5db991ababa42e3"
    const URL = `https://api.openweathermap.org/data/2.5/forecast?lat=${this.lat}&lon=${this.long}&units=metric&appid=${API_key}`
    console.log(URL)
    const response = await fetch(URL)
    const data = await response.json()

    // console.log(data.city.name)

    let daysData = data.list.map(element => {
      return {
        temp: element.main.temp,
        iconId: element.weather[0].icon
      }
    })

    let filtereddaysData = [daysData[0], daysData[7], daysData[15], daysData[23], daysData[31]]

    await this.upDateHTML(filtereddaysData)
  }

  upDateHTML = async function(filtereddaysData) {
    filtereddaysData.forEach(data => {
      this.outputTarget.insertAdjacentHTML('beforeend',
      `<div class="d-flex flex-column align-items-center">
        <div class="fs-5">${data.temp}°C</div>
        <img src="https://openweathermap.org/img/wn/${data.iconId}@2x.png">
      </div>`
      )
    })
  }
}
