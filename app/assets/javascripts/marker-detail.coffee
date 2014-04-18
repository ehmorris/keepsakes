$ ->
  window.attach_feature_layer_events()

window.attach_feature_layer_events = ->
  window.feature_layer.on 'click', activate_marker_detail

$(document).on 'click', '.meta.marker-detail', ->
  deactivate_marker_detail(@)

activate_marker_detail = (point) ->
  current_zoom = window.map.getZoom()
  window.map.panTo(point.layer.getLatLng()).setZoom(18)

  $random_marker_detail = $(".meta.marker-detail:eq(#{random_number_between(0, 2)})")

  $random_marker_detail.data('point', point)
  $random_marker_detail.data('zoom', current_zoom)
  $random_marker_detail.addClass('processed')

  style_active_marker(point)
  arrange_marker_detail_items()
  set_marker_title(point)
  set_marker_next_prev_locations(point)
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

deactivate_marker_detail = (marker_detail) ->
  window.map.setZoom $(marker_detail).data('zoom')
  reset_marker_style $(marker_detail).data('point')

get_all_markers = ->
  markers = []
  $.each window.feature_layer.getLayers(), (index, layer) ->
    if layer.feature.geometry.type == 'Point'
      markers.push
        arrival: layer.feature.geometry.arrival
        title: layer.feature.properties.title
  markers

set_marker_title = (point) ->
  $('.marker-detail .title').text point.layer.feature.properties.title

set_marker_next_prev_locations = (point) ->
  all_markers = get_all_markers()
  for marker, i in all_markers
    if marker.arrival == point.layer.feature.geometry.arrival
      if all_markers[i+1]
        $('.marker-detail .detail-next').text "Left for #{all_markers[i+1].title}"
      if all_markers[i-1]
        $('.marker-detail .detail-previous').text "Came from #{all_markers[i-1].title}"

arrange_marker_detail_items = ->
  $('.marker-detail .item').each ->
    top_value = random_number_between(6, 68)
    left_value = random_number_between(6, 68)
    $item = $(@)
    $item.css {
      top: "#{top_value}%"
      left: "#{left_value}%"
    }
  .draggable {
    containment: '.marker-detail'
    scroll: false
  }

style_active_marker = (point) ->
  point.layer.feature.properties['marker-size'] = 'large'
  point.layer.feature.properties['marker-color'] = '#fff'
  window.feature_layer.setGeoJSON {
    type: 'FeatureCollection',
    features: window.feature_layer.getGeoJSON().features.concat point
  }

reset_marker_style = (point) ->
  point.layer.feature.properties['marker-size'] = ''
  point.layer.feature.properties['marker-color'] = ''
  window.feature_layer.setGeoJSON {
    type: 'FeatureCollection',
    features: window.feature_layer.getGeoJSON().features.concat point
  }

random_number_between = (min, max)->
  Math.round(Math.random() * (max - min) + min)
