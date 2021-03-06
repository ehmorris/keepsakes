$ -> window.render_map()

window.render_map = ->
  if window.feature_layer
    window.feature_layer.clearLayers()

  window.map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag', { zoomControl: false })

  geodata_json = $('#map').data('geojson')

  if geodata_json.length > 0
    # initialize empty collection for getGeoJSON function within set_points_boundary
    window.feature_layer = L.mapbox.featureLayer
      type: 'FeatureCollection'
      features: []

    # aggregate all geodata into one object to determine boundaries
    $.each geodata_json, ->
      if @.activity == 'wlk'
        properties =
          'title': @.title
          'stroke': '#fff'
          'stroke-opacity': .9
          'stroke-width': 5
      else
        properties =
          'title': @.title
          'stroke': '#999'
          'stroke-opacity': .5
          'stroke-width': 5

      window.feature_layer = L.mapbox.featureLayer
        type: 'FeatureCollection'
        features: window.feature_layer.getGeoJSON().features.concat
          type: 'Feature'
          geometry: @
          properties: properties

    # zoom the map to fit the boundaries, but don't plot any points
    window.map.fitBounds(window.feature_layer.getBounds())

    # plot all the points at once
    window.feature_layer.addTo window.map

window.get_all_markers = ->
  markers = []
  $.each window.feature_layer.getLayers(), (index, layer) ->
    if layer.feature.geometry.type == 'Point'
      markers.push
        layer: layer
  markers
