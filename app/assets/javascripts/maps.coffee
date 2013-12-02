$ ->
  geodata_json = $('#map').data('geojson')

  map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag', { zoomControl: false })

  set_boundary = ->
    # initialize empty collection for getGeoJSON function
    marker_layer = L.mapbox.markerLayer({
      type: 'FeatureCollection',
      features: []})

    # aggregate all points into one object to determine boundary
    $.each geodata_json, ->
      marker_layer = L.mapbox.markerLayer({
        type: 'FeatureCollection',
        features: marker_layer.getGeoJSON().features.concat({
          type: 'Feature',
          geometry: this,
          properties: {}
        })})

    map.fitBounds marker_layer.getBounds()

  count = 0
  render_points = ->
    point = {
      type: 'Feature',
      geometry: geodata_json[count],
      properties: {
        'title': geodata_json[count].title
      }}

    # add only the current point to the map
    L.mapbox.markerLayer(point).addTo map

    # recurse function until all points are plotted
    if ++count < geodata_json.length
      # set delay to animate the line drawing
      window.setTimeout(render_points, 10)

  set_boundary()
  render_points()
