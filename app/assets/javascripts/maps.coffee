$ ->
  geojson_array = {}

  map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag')
                .setView([42.332, -71.106], 16)

  $.each geojson_array, ->
    L.mapbox.markerLayer({
      type: 'Feature',
      geometry: this,
      properties: {}
    }).addTo map
