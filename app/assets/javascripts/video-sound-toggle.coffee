$(document).on
  mouseenter: -> toggle_video_mute(@)
  mouseleave: -> toggle_video_mute(@)
, '.meta.photos.processed .item.video, .meta.marker-detail .item.video'

toggle_video_mute = (video_container) ->
  $video = $(video_container).find('video')
  $video.prop('muted', !$video.prop('muted'))
