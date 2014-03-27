$ ->
  if window.location.search == '?temp=warm'
    map = L.mapbox.map('map', 'ehmorris.gecdn03c', { zoomControl: false })
  else if window.location.search == '?temp=cold'
    map = L.mapbox.map('map', 'ehmorris.gecdf0am', { zoomControl: false })
  else
    map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag', { zoomControl: false })

  geodata_json = {}
  
  get_geodata_json = ->
    geodata_json = $('#map').data('geojson')

  set_points_boundary = ->
    # initialize empty collection for getGeoJSON function
    marker_layer = L.mapbox.featureLayer({
      type: 'FeatureCollection',
      features: []})

    # aggregate all points into one object to determine boundary
    $.each geodata_json, ->
      marker_layer = L.mapbox.featureLayer({
        type: 'FeatureCollection',
        features: marker_layer.getGeoJSON().features.concat({
          type: 'Feature',
          geometry: this,
          properties: {}
        })})

    map.fitBounds(marker_layer.getBounds())

  point_sequence_counter = 0
  render_points_sequentially = ->
    point = {
      type: 'Feature',
      geometry: geodata_json[point_sequence_counter],
      properties: {
        'title': geodata_json[point_sequence_counter].title
        'stroke': '#fff'
        'stroke-opacity': .9
        'stroke-width': 5
      }}

    # add only the current point to the map
    L.mapbox.featureLayer(point).addTo map

    # recurse function until all points are plotted
    if ++point_sequence_counter < geodata_json.length
      # set delay to animate the line drawing
      window.setTimeout(render_points_sequentially, 10)

  get_geodata_json()
  set_points_boundary()
  render_points_sequentially()

  map.featureLayer.on 'click', (e) ->
    console.log 'test'
    map.panTo(e.layer.getLatLng())
