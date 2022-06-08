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

    try {
      const URL = `https://api.windy.com/api/webcams/v2/list/nearby=${this.lat},${this.long},5?show=webcams:location,url`
      let response = await fetch(URL,
        {headers: {"x-windy-key": this.apiKey}},
        )
      let data = await response.json()

      let filteredData = data.result.webcams
        .filter(cam => cam.status === "active")
        .map(cam => {
          return {
            cam_url: cam.url.current.mobile,
            cam_title: cam.title
          }
        })
        await this.upDateHTML(filteredData)

    } catch (error) {
      console.log(error)
    }

  }

  upDateHTML = async function(filteredData) {
    console.log(filteredData)
    filteredData.forEach(elem => {
      this.outputTarget.insertAdjacentHTML('beforeend',
      `<li>
        <i class="fas fa-camera" style="color: #01B2B2"></i>
        <a href="${elem.cam_url}" class="text-decoration-none text-secondary" target="_blank">${elem.cam_title}</a>
      </li>`
      )
    })
  }
}
