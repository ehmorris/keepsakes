$ ->
  if window.location.search == '?temp=warm'
    window.map = L.mapbox.map('map', 'ehmorris.gecdn03c', { zoomControl: false })
  else if window.location.search == '?temp=cold'
    window.map = L.mapbox.map('map', 'ehmorris.gecdf0am', { zoomControl: false })
  else
    window.map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag', { zoomControl: false })

  geodata_json = $('#map').data('geojson')

  # initialize empty collection for getGeoJSON function within set_points_boundary
  window.feature_layer = L.mapbox.featureLayer({
    type: 'FeatureCollection',
    features: []})

  # aggregate all geodata into one object to determine boundaries
  $.each geodata_json, ->
    if @.activity == 'wlk'
      properties = {
        'title': @.title
        'stroke': '#fff'
        'stroke-opacity': .9
        'stroke-width': 5}
    else
      properties = {
        'title': @.title
        'stroke': '#999'
        'stroke-opacity': .5
        'stroke-width': 5}

    window.feature_layer = L.mapbox.featureLayer {
      type: 'FeatureCollection',
      features: window.feature_layer.getGeoJSON().features.concat {
        type: 'Feature',
        geometry: @,
        properties: properties}}

  # zoom the map to fit the boundaries, but don't plot any points
  window.map.fitBounds(window.feature_layer.getBounds())

  # plot all the points at once
  window.feature_layer.addTo window.map
