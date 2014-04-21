$('.today-text, .tomorrow-link, .yesterday-link, .map, .calendar').remove()
$('body').append('<%= escape_javascript(render :partial => 'map') %>')
$('.upper-nav').append('<%= escape_javascript(render :partial => 'calendar') %>')

window.render_map()
window.attach_feature_layer_events()
window.deactivate_day_loading_animation()

window.history.pushState null, null, $('.map-today').data('today')
