import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    userCoordinates: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.userLocation = this.userCoordinatesValue

    console.log(this.userLocation)

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.getIsochrones()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  // Create a function that sets up the Isochrone API query then makes an fetch call
  fetchIso = async function () {
    console.log("fetchIso")
    // Create constants to use in getIso()
    const urlBase = 'https://api.mapbox.com/isochrone/v1/mapbox/';
    const lon = this.userLocation[0]
    const lat = this.userLocation[1]
    const profile = 'cycling'; // Set the default routing profile
    const minutes = 30; // Set the default duration

    const query = await fetch(
      `${urlBase}${profile}/${lon},${lat}?contours_minutes=${minutes}&polygons=true&access_token=${mapboxgl.accessToken}`,
      { method: 'GET' }
    );
    const data = await query.json();
    // Set the 'iso' source's data to what's returned by the API query
    this.map.getSource('iso').setData(data);
  }

  getIsochrones(){
    console.log("started getIsochrones")
    this.map.on('load', () => {
      // When the map loads, add the source and layer
      this.map.addSource('iso', {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: []
        }
      });

      this.map.addLayer(
        {
          id: 'isoLayer',
          type: 'fill',
          // Use "iso" as the data source for this layer
          source: 'iso',
          layout: {},
          paint: {
            // The fill color for the layer is set to a light purple
            'fill-color': '#5a3fc0',
            'fill-opacity': 0.3
          }
        },
        // 'poi-label'
      );

      // Make the API call
      this.fetchIso()
    });


  }

}
