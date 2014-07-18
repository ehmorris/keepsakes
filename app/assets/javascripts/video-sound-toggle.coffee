$(document).on
  mouseenter: -> toggle_video_mute(@)
  mouseleave: -> toggle_video_mute(@)
, '.meta.photos.processed .item video'

toggle_video_mute = (video_tag) ->
  $(video_tag).prop('muted', !$(video_tag).prop('muted'))
