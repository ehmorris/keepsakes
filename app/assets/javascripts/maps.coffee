$ -> window.render_map()

window.render_map = ->
  mapboxgl.accessToken = $('#map').data('mapbox-public-token')
  mapboxgl.util.getJSON '/assets/bright-v4.json', (error, style) ->
    style.layers.push
      "id": "markers",
      "source": "markers",
      "render": {
        "$type": "Point",
        "text-field": "@title"
      },
      "type": "symbol"

    window.map = new mapboxgl.Map
      container: 'map'
      style: style

    geodata_json = $(map).data('geojson')

    console.log 'test'

    if geodata_json.length > 0
      window.feature_layer =
        new mapboxgl.GeoJSONSource
          data:
            type: 'FeatureCollection'
            features: []

      $.each geodata_json, ->
        if @.type is 'Point'
          window.feature_layer = new mapboxgl.GeoJSONSource
            data:
              type: 'FeatureCollection'
              features: window.feature_layer.data.features.concat
                type: 'Feature'
                geometry: @
                properties: { 'title': @.title }

      window.map.fitBounds(new mapboxgl.LatLngBounds([
        [40.66005539269824, -74.0257876666108],
        [40.721222070257966, -73.9529640990072]]))

      window.map.addSource('markers', window.feature_layer)
