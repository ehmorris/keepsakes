$ -> window.render_map()

window.render_map = ->
  if window.feature_layer?
    window.map.removeSource('walking')
    window.map.removeSource('transport')
    window.map.removeSource('markers')

  mapboxgl.accessToken = $('#map').data('mapbox-public-token')
  mapboxgl.util.getJSON '/assets/mapbox-styles.json', (error, style) ->
    style.layers.push({
      "id": "markers",
      "source": "markers",
      "render": {
        "$type": "Point",
        "text-field": "@title"
      },
      "type": "symbol"
    })
    style.layers.push({
      "id": "transport",
      "source": "transport",
      "render": {
        "$type": "LineString",
        "line-join": "round",
        "line-cap": "round"
      },
      "style": {
        "line-color": "#999",
        "line-width": 5,
        "line-opacity": 0.5
      },
      "type": "line"
    })
    style.layers.push({
      "id": "walking",
      "source": "walking",
      "render": {
        "$type": "LineString",
        "line-join": "round",
        "line-cap": "round"
      },
      "style": {
        "line-color": "#fff",
        "line-width": 5,
        "line-opacity": 0.9
      },
      "type": "line"
    })

    window.map = new mapboxgl.Map
      container: 'map'
      style: style

    geodata_json = $('#map').data('geojson')
    if geodata_json.length > 0
      new_geojson_source = ->
        new mapboxgl.GeoJSONSource
          data:
            type: 'FeatureCollection'
            features: []

      window.feature_layer = {}
      window.feature_layer.walking = new_geojson_source()
      window.feature_layer.transport = new_geojson_source()
      window.feature_layer.markers = new_geojson_source()

      add_feature_to_layer = (geometry, layer, properties = {}) ->
        layer = new mapboxgl.GeoJSONSource
          data:
            type: 'FeatureCollection'
            features: layer.data.features.concat
              type: 'Feature'
              geometry: geometry
              properties: properties

      $.each geodata_json, ->
        if @.type is 'Point'
          properties = { 'title': @.title }
          add_feature_to_layer(@, window.feature_layer.markers, properties)
        else if @.type is 'LineString' and @.activity is 'wlk'
          add_feature_to_layer(@, window.feature_layer.walking)
        else if @.type is 'LineString'
          add_feature_to_layer(@, window.feature_layer.transport)

      window.map.fitBounds(new mapboxgl.LatLngBounds([
        [40.66005539269824, -74.0257876666108],
        [40.721222070257966, -73.9529640990072]]))

      window.map.addSource('walking', window.feature_layer.walking)
      window.map.addSource('transport', window.feature_layer.transport)
      window.map.addSource('markers', window.feature_layer.markers)

window.get_all_markers = ->
  markers = []
  $.each window.feature_layer.getLayers(), (index, layer) ->
    if layer.feature.geometry.type is 'Point'
      markers.push

window.get_all_markers = ->
  markers = []
  $.each window.feature_layer.getLayers(), (index, layer) ->
    if layer.feature.geometry.type is 'Point'
      markers.push
        layer: layer
  markers
