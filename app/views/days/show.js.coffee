$('.tomorrow-link,
   .yesterday-link,
   .map,
   .calendar,
   .meta.places,
   .meta.photos,
   nav.meta').remove()

$('body').append('<%= escape_javascript(render :partial => "map") %>')
$('.upper-nav').append('<%= escape_javascript(render :partial => "calendar") %>')
$('.activate-meta-nav').after('<%= escape_javascript(render :partial => "meta-nav") %>')
$('.meta.journal').before('<%= escape_javascript(render :partial => "places") %>')
$('.meta.music').after('<%= escape_javascript(render :partial => "photos") %>')

window.render_map()
window.attach_feature_layer_events()
window.deactivate_day_loading_animation()
window.tilt_hint()

window.history.pushState null, null, $('.map-today').data('today')
