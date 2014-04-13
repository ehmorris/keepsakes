$ ->
  # zoom to a marker and open the detail view
  $(document).on {
    click: (point) ->
      current_zoom = window.map.getZoom()
      window.map.panTo(point.layer.getLatLng()).setZoom(18)
      style_active_marker(point)

      $random_marker_detail = $(".meta.marker-detail:eq(#{random_number_between(0, 2)})")
      $random_marker_detail.data('point', point)
      $random_marker_detail.data('zoom', current_zoom)
      $random_marker_detail.addClass('processed')
      arrange_marker_detail_items()
      $random_marker_detail.children('.title').text(point.layer.feature.properties.title)
      $('.yesterday-link, .tomorrow-link').addClass 'hide'
  }, window.feature_layer

  # zoom map back out to previous zoom level after exiting the detail view
  # reset the clicked marker's styles
  $('.meta.marker-detail').on 'click', ->
    window.map.setZoom $(@).data('zoom')
    reset_marker $(@).data('point')

  # cancel out close action when clicking on things inside the detail view 
  $('.meta.marker-detail .item, .meta.marker-detail h2'). on 'click', ->
    false

  $('.marker-detail .item').draggable {
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

arrange_marker_detail_items = ->
  $('.marker-detail .item').each ->
    top_value = random_number_between(6, 68)
    left_value = random_number_between(6, 68)
    $item = $(@)
    $item.css {
      '-webkit-transition': 'all .5s ease'
      'transition': 'all .5s ease'
      top: "#{top_value}%"
      left: "#{left_value}%"
    }
    setTimeout ->
      $item.css {
        '-webkit-transition': 'none'
        'transition': 'none'
      }
    , 1500

reset_marker = (point) ->
  point.layer.feature.properties['marker-size'] = ''
  point.layer.feature.properties['marker-color'] = ''
  window.feature_layer.setGeoJSON {
    type: 'FeatureCollection',
    features: window.feature_layer.getGeoJSON().features.concat point
  }

random_number_between = (min, max)->
  Math.round(Math.random() * (max - min) + min)
