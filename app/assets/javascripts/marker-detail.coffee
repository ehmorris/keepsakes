$ ->
  window.attach_feature_layer_events()

window.attach_feature_layer_events = ->
  window.feature_layer.on 'click', activate_marker_detail

$(document).on 'click', '.meta.marker-detail', ->
  deactivate_marker_detail(@)

$(document).on 'click', '.detail-previous, .detail-next', ->
  window.deactivate_meta_panes()
  reset_marker_style $(@).parents('.marker-detail').data('point')
  activate_marker_detail($(@).data('point'))

activate_marker_detail = (point) ->
  if window.map.getZoom() != 18 then current_zoom = window.map.getZoom()
  window.map.panTo(point.layer.getLatLng()).setZoom(18)

  $random_marker_detail = $(".meta.marker-detail:eq(#{random_number_between(0, 2)})")

  $random_marker_detail.data('point', point)
  $random_marker_detail.data('zoom', current_zoom)
  $random_marker_detail.addClass('processed')

  style_active_marker(point)
  arrange_marker_detail_items()
  set_marker_title(point)
  set_marker_time(point)
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
        layer: layer
  markers

set_marker_title = (point) ->
  $('.marker-detail .title').text point.layer.feature.properties.title

set_marker_time = (point) ->
  $('.marker-detail .time .arrived').text "Arrived at #{point.layer.feature.geometry.arrival}."
  $('.marker-detail .time .duration').text "Spent #{point.layer.feature.geometry.duration} here."

set_marker_next_prev_locations = (point) ->
  all_markers = get_all_markers()
  for marker, i in all_markers
    if marker.layer.feature.geometry.arrival == point.layer.feature.geometry.arrival
      if all_markers[i-1]
        $('.marker-detail .detail-previous')
        .text "Came from #{all_markers[i-1].layer.feature.properties.title}"
        .data 'point', all_markers[i-1]
      else
        $('.marker-detail .detail-previous').text ''
      if all_markers[i+1]
        $('.marker-detail .detail-next')
        .text "Left for #{all_markers[i+1].layer.feature.properties.title}"
        .data 'point', all_markers[i+1]
      else
        $('.marker-detail .detail-next').text ''

arrange_marker_detail_items = ->
  $('.marker-detail .item').each ->
    top_value = random_number_between(1, 65).closest_divisible_by(6.25)
    left_value = random_number_between(20, 80).closest_divisible_by(6.25)
    $(@).css
      top: "#{top_value}vh"
      left: "#{left_value}vw"

style_active_marker = (point) ->
  point.layer.feature.properties['marker-size'] = 'large'
  point.layer.feature.properties['marker-color'] = '#fff'
  window.feature_layer.setGeoJSON
    type: 'FeatureCollection'
    features: window.feature_layer.getGeoJSON().features.concat point

reset_marker_style = (point) ->
  point.layer.feature.properties['marker-size'] = ''
  point.layer.feature.properties['marker-color'] = ''
  window.feature_layer.setGeoJSON
    type: 'FeatureCollection'
    features: window.feature_layer.getGeoJSON().features.concat point

random_number_between = (min, max)->
  Math.round(Math.random() * (max - min) + min)

Number::closest_divisible_by = (divisor) ->
  Math.round(this / divisor) * divisor
