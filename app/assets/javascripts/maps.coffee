$ -> window.render_map()

window.render_map = ->
  if window.feature_layer
    window.map.removeSource('daygeojson')

  mapboxgl.accessToken = $('#map').data('mapbox-public-token')
  window.map = new mapboxgl.Map
    container: 'map'
    style: '/assets/bright-v4.json'

  geodata_json = $('#map').data('geojson')

  if geodata_json.length > 0
    # initialize empty collection for getGeoJSON function within set_points_boundary
    window.feature_layer = new mapboxgl.GeoJSONSource
      data:
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

      window.feature_layer = new mapboxgl.GeoJSONSource
        data:
          type: 'FeatureCollection'
          features: window.feature_layer.data.features.concat
            type: 'Feature'
            geometry: @
            properties: properties

    # zoom the map to fit the boundaries, but don't plot any points
    # feature_bounds = new mapboxgl.LatLngBounds([southwest, northwest])
    # window.map.fitBounds(feature_bounds)

    # plot all the points at once
    window.map.addSource('daygeojson', window.feature_layer)

window.get_all_markers = ->
  markers = []
  $.each window.feature_layer.getLayers(), (index, layer) ->
    if layer.feature.geometry.type == 'Point'
      markers.push
        layer: layer
  markers
