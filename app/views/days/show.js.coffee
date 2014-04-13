$('.today-text, .tomorrow-link, .yesterday-link, .map').remove()
$('body').append('<%= escape_javascript(render :partial => 'map') %>')

window.render_map()

today = $('.map-today').data('today')
window.history.pushState null, null, today
