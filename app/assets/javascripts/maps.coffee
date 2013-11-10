$ ->
  geodata_json = $('#map').data('geojson')

  map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag')

  geodata_json_feature_set = []
  $.each geodata_json, ->
    geodata_json_feature_set.push({
      type: 'Feature',
      geometry: this,
      properties: {'title': this.title}
    })

  marker_layer = L.mapbox.markerLayer(geodata_json_feature_set).addTo map

  map.fitBounds marker_layer.getBounds()
