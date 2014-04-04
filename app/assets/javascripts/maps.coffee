$ ->
  if window.location.search == '?temp=warm'
    map = L.mapbox.map('map', 'ehmorris.gecdn03c', { zoomControl: false })
  else if window.location.search == '?temp=cold'
    map = L.mapbox.map('map', 'ehmorris.gecdf0am', { zoomControl: false })
  else
    map = L.mapbox.map('map', 'ehmorris.map-lfrw1qag', { zoomControl: false })

  geodata_json = $('#map').data('geojson')

  # initialize empty collection for getGeoJSON function within set_points_boundary
  feature_layer = L.mapbox.featureLayer({
    type: 'FeatureCollection',
    features: []})

  # aggregate all geodata into one object to determine boundaries
  $.each geodata_json, ->
    feature_layer = L.mapbox.featureLayer {
      type: 'FeatureCollection',
      features: feature_layer.getGeoJSON().features.concat {
        type: 'Feature',
        geometry: this,
        properties: {
          'title': this.title
          'stroke': '#fff'
          'stroke-opacity': .9
          'stroke-width': 5
        }}}

  # zoom the map to fit the boundaries, but don't plot any points
  map.fitBounds(feature_layer.getBounds())

  # plot all the points at once
  feature_layer.addTo map

  feature_layer.on 'click', (point) ->
    map.panTo(point.layer.getLatLng()).setZoom(18)
    point.layer.feature.properties['marker-size'] = 'large'
    point.layer.feature.properties['marker-color'] = '#fff'
    feature_layer.setGeoJSON {
      type: 'FeatureCollection',
      features: feature_layer.getGeoJSON().features.concat point
    }

    $('.meta.detail').addClass 'processed'
    $('.yesterday-link, .tomorrow-link').addClass 'hide'

    $('.meta.detail .title').text(point.layer.feature.properties.title)

  $('.meta.detail').on 'click', ->
    map.fitBounds(feature_layer.getBounds())

  reset_markers = ->
    # cycle through each point in the feature layer, set the marker
    # color and size to the default values, then setGeoJSON
    console.log 'reset all markers'

  feature_layer.on 'click', reset_markers
