$ ->
  geodata_json = $('#map').data('geojson')

  map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag')
                .setView([42.348, -71.085], 14)

  $.each geodata_json, ->
    L.mapbox.markerLayer({
      type: 'Feature',
      geometry: this,
      properties: {'title': this.title}
    }).addTo map
