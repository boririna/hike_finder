import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]
  static values = {
    apiKey: String,
    latitude: Number,
    longitude: Number
  }

  connect() {
    this.apiKey = this.apiKeyValue
    this.lat = this.latitudeValue
    this.long = this.longitudeValue
    this.fetchData()
  }

  fetchData = async function() {
    const URL = `https://api.openweathermap.org/data/2.5/forecast?lat=${this.lat}&lon=${this.long}&units=metric&appid=${this.apiKey}`
    console.log(URL)
    const response = await fetch(URL)
    const data = await response.json()
    data.list[0].main.temp

    let daysData = data.list.map(element => {
      return {
        temp: element.main.temp.toFixed(1),
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
