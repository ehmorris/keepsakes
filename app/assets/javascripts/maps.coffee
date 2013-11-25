$ ->
  geodata_json = $('#map').data('geojson')

  map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag')

  # initialize empty collection for getGeoJSON function
  marker_layer = L.mapbox.markerLayer({
    type: 'FeatureCollection',
    features: []})

  count = 0
  render_point = ->
    point_geojson = {
      type: 'Feature',
      geometry: geodata_json[count],
      properties: {
        'title': geodata_json[count].title
      }}

    # add only the current point to the map
    L.mapbox.markerLayer(point_geojson).addTo map

    # aggregate all points into one object to determine boundary
    marker_layer = L.mapbox.markerLayer({
      type: 'FeatureCollection',
      features: marker_layer.getGeoJSON().features.concat(point_geojson)
      })
    map.fitBounds marker_layer.getBounds()

    # recurse function until all points are plotted
    if ++count < geodata_json.length
      # set delay to animate the line drawing
      window.setTimeout(render_point, 10)

  render_point()
