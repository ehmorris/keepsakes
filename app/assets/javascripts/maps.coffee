$ ->
  map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag', { zoomControl: false })
  geodata_json = {}
  
  get_geodata_json = ->
    geodata_json = $('#map').data('geojson')

  set_points_boundary = ->
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

  point_sequence_counter = 0
  render_points_sequentially = ->
    point = {
      type: 'Feature',
      geometry: geodata_json[point_sequence_counter],
      properties: {
        'title': geodata_json[point_sequence_counter].title
      }}

    # add only the current point to the map
    L.mapbox.markerLayer(point).addTo map

    # recurse function until all points are plotted
    if ++point_sequence_counter < geodata_json.length
      # set delay to animate the line drawing
      window.setTimeout(render_points_sequentially, 10)

  get_geodata_json()
  set_points_boundary()
  render_points_sequentially()
