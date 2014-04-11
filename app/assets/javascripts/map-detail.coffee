$ ->
  # zoom to a marker and open the detail view
  window.feature_layer.on 'click', (point) ->
    window.map.panTo(point.layer.getLatLng()).setZoom(18)
    style_active_marker(point)

    $random_marker_detail = $(".meta.marker-detail:eq(#{random_number_between(0, 2)})")

    $($random_marker_detail).data('point', point)
    $($random_marker_detail).addClass 'processed'
    arrange_marker_detail_items()
    $random_marker_detail.children('.title').text(point.layer.feature.properties.title)
    $('.yesterday-link, .tomorrow-link').addClass 'hide'

  # zoom map back out to boundaries after exiting the detail view
  $('.meta.marker-detail').on 'click', ->
    reset_marker($(@).data('point'))
    window.map.fitBounds(window.feature_layer.getBounds())

  # cancel out close action when clicking on things inside the detail view 
  $('.meta.marker-detail .item'). on 'click', ->
    false

  $('.marker-detail .item').draggable {
    containment: '.marker-detail'
    scroll: false
  }

style_active_marker = (point) ->
  point.layer.feature.properties['marker-size'] = 'large'
  point.layer.feature.properties['marker-color'] = '#71A052'
  window.feature_layer.setGeoJSON {
    type: 'FeatureCollection',
    features: window.feature_layer.getGeoJSON().features.concat point
  }

arrange_marker_detail_items = ->
  $('.marker-detail .item').each ->
    top_value = random_number_between(6, 68)
    left_value = random_number_between(6, 68)
    $(@).css {
      top: "#{top_value}%"
      left: "#{left_value}%"
    }

reset_marker = (point) ->
  point.layer.feature.properties['marker-size'] = ''
  point.layer.feature.properties['marker-color'] = ''
  window.feature_layer.setGeoJSON {
    type: 'FeatureCollection',
    features: window.feature_layer.getGeoJSON().features.concat point
  }

random_number_between = (min, max)->
  Math.round(Math.random() * (max - min) + min)
