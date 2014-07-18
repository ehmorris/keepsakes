$('.tomorrow-link,
   .yesterday-link,
   .map,
   .calendar,
   .meta.places,
   .meta.photos,
   .meta.marker-detail,
   nav.meta').remove()

$('body').append('<%= escape_javascript(render :partial => "map") %>')
$('.upper-nav').append('<%= escape_javascript(render :partial => "calendar") %>')
$('.activate-meta-nav').after('<%= escape_javascript(render :partial => "meta-nav") %>')
$('.partial-anchor').after('<%= escape_javascript(render :partial => "places") %>')
$('.partial-anchor').after('<%= escape_javascript(render :partial => "photos") %>')
$('.partial-anchor').after('<%= escape_javascript(render :partial => "marker-details") %>')

window.render_map()
window.attach_feature_layer_events()
window.deactivate_day_loading_animation()
window.tilt_hint()

window.history.pushState null, null, $('.map-today').data('today')
