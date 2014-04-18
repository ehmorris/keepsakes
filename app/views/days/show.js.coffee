$('.today-text, .tomorrow-link, .yesterday-link, .map').remove()
$('body').append('<%= escape_javascript(render :partial => 'map') %>')

window.render_map()
window.attach_marker_detail_events()
window.deactivate_map_loading_animation()

window.history.pushState null, null, $('.map-today').data('today')
