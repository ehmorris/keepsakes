$(document).on
  mouseover: ->
    for marker, i in window.get_all_markers()
      if marker.layer.feature.geometry.arrival == $(@).data('arrival')
        window.map.panTo(marker.layer.getLatLng())
        marker.layer.openPopup()
  click: ->
    for marker, i in window.get_all_markers()
      if marker.layer.feature.geometry.arrival == $(@).data('arrival')
        window.deactivate_meta_panes()
        window.activate_marker_detail(marker)
  , '.meta.places .place'
