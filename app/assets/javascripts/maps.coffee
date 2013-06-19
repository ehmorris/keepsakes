$ ->
  geojson_array = {}

  map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag')
                .setView([42.348, -71.085], 14)

  $.each geojson_array, ->
    L.mapbox.markerLayer({
      type: 'Feature',
      geometry: this,
      properties: {}
    }).addTo map
