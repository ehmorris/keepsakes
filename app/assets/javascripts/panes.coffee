$ ->
  activate_day_loading_animation()
  deactivate_day_loading_animation()
  # setTimeout tilt_hint 5000

  $(document).on
    mouseenter: recess_maps
    mouseleave: clear_map_position_classes
  , '.yesterday-link, .tomorrow-link'

  $(document).on
    mouseenter: tilt_map_up
    mouseleave: untilt_map
  , '.activate-upper-nav'

  $(document).on
    mouseenter: tilt_map_down
    mouseleave: untilt_map
  , '.activate-meta-nav'

  $(document).on 'click', '.activate-upper-nav', activate_upper_nav

  $(document).on 'click', '.deactivate-upper-nav', deactivate_upper_nav

  $(document).on 'click', '.activate-meta-nav', activate_meta_nav

  $(document).on 'click', '.deactivate-meta-nav', deactivate_meta_nav

  $(document).on 'click', '.activate-meta-pane', ->
    target = $(@).data('target')
    activate_meta_pane(".meta.#{target}")
    false
  
  $(document).on 'click', 'div.meta', deactivate_meta_panes

  $(document).on 'click', 'div.meta:not(.marker-detail)', activate_meta_nav

  $(document).on 'click', 'div.meta *:not(h2)', false

  $(document).on 'click', '.tomorrow-link, .calendar .forwards', ->
    loading_text = $(@).data('loading-text')
    activate_day_loading_animation('tomorrow', loading_text)

  $(document).on 'click', '.yesterday-link, .calendar .backwards', ->
    loading_text = $(@).data('loading-text')
    activate_day_loading_animation('yesterday', loading_text)

  $(document).on 'submit', '.search form', (e) ->
    e.preventDefault()
    if moment($('.search input').val()).isValid()
      day_id = moment($('.search input').val()).format('YYYY-MM-DD')
      document.location.href = "/days/#{day_id}"
    else
      $('.search').addClass 'invalid'

tilt_map_up = ->
  $('.map-today').addClass 'tilt-up'
  $('.upper-nav').addClass 'tilt-expose'

tilt_map_down = ->
  $('.map-today').addClass 'tilt-down'
  $('nav.meta').addClass 'tilt-expose'

untilt_map = ->
  $('.map').removeClass 'tilt-up tilt-down'
  $('nav.meta, .upper-nav').removeClass 'tilt-expose'

window.tilt_hint = ->
  wait_between_tilts = 1000
  tilt_duration = 2000

  tilt_map_up()
  setTimeout untilt_map, tilt_duration
  setTimeout tilt_map_down, wait_between_tilts + tilt_duration
  setTimeout untilt_map, wait_between_tilts + tilt_duration * 2

activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  recess_maps()

window.deactivate_meta_panes = ->
  clear_map_position_classes()
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'
  $('div.meta').removeClass 'processed'

activate_upper_nav = ->
  push_maps_down()
  scroll_to_center('.calendar')
  $('.map-today').removeClass 'tilt-up'
  $('.upper-nav').addClass 'processed'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

deactivate_upper_nav = ->
  clear_map_position_classes()
  $('.upper-nav').removeClass 'processed'
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

activate_meta_nav = ->
  push_maps_up()
  $('.map-today').removeClass 'tilt-down'
  $('nav.meta').addClass 'processed'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

deactivate_meta_nav = ->
  clear_map_position_classes()
  $('nav.meta').removeClass 'processed'
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

activate_day_loading_animation = (direction = 'yesterday', loading_text) ->
  deactivate_upper_nav()
  $('.map').addClass "load-#{direction}"
  $('.loading-text span').text(loading_text).parent().addClass 'show pulse'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

window.deactivate_day_loading_animation = ->
  clear_map_loading_classes()
  $('.loading-text').removeClass 'pulse'
  setTimeout ->
    $('.loading-text').removeClass 'show'
  , 1800
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

recess_maps = ->
  $('.map-today').addClass 'recessed'
  if $('.tomorrow-link').length
    $('.map-tomorrow').addClass 'recessed'
  if $('.yesterday-link').length
    $('.map-yesterday').addClass 'recessed'

push_maps_down = ->
  $('.map-today').addClass 'down'
  if $('.tomorrow-link').length
    $('.map-tomorrow').addClass 'down'
  if $('.yesterday-link').length
    $('.map-yesterday').addClass 'down'

push_maps_up = ->
  $('.map-today').addClass 'up'
  if $('.tomorrow-link').length
    $('.map-tomorrow').addClass 'up'
  if $('.yesterday-link').length
    $('.map-yesterday').addClass 'up'

clear_map_position_classes = ->
  $('.map').removeClass 'recessed down up tilt-up tilt-down'

clear_map_loading_classes = ->
  $('.map').removeClass 'load-tomorrow load-yesterday'

scroll_to_center = (container) ->
  $(container).scrollLeft(
    ($(container).get(0).scrollWidth / 2) - ($(container).width() / 2))
