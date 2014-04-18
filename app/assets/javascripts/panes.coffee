$ ->
  $(document).on {
    mouseenter: recess_maps
    mouseleave: clear_map_classes
  }, '.yesterday-link, .tomorrow-link'

  $(document).on {
    mouseenter: tilt_map_up
    mouseleave: untilt_map
  }, '.activate-upper-nav'

  $(document).on {
    mouseenter: tilt_map_down
    mouseleave: untilt_map
  }, '.activate-meta-nav'

  $('.activate-upper-nav').on 'click', activate_upper_nav

  $('.deactivate-upper-nav').on 'click', deactivate_upper_nav

  $('.activate-meta-nav').on 'click', activate_meta_nav

  $('.deactivate-meta-nav').on 'click', deactivate_meta_nav

  $('.activate-meta-pane').on 'click', ->
    target = $(@).data('target')
    deactivate_upper_nav()
    activate_meta_pane(".meta.#{target}")
    false

  $('div.meta').on 'click', deactivate_meta_panes

  $('div.meta article').on 'click', false

  $('div.meta:not(.marker-detail)').on 'click', activate_meta_nav

  $(document).on 'click', '.tomorrow-link', ->
    activate_map_loading_animation('tomorrow')

  $(document).on 'click', '.yesterday-link', ->
    activate_map_loading_animation('yesterday')

tilt_map_up = ->
  $('.map-today').addClass 'tilt-up'
  $('.upper-nav').addClass 'tilt-expose'

tilt_map_down = ->
  $('.map-today').addClass 'tilt-down'
  $('nav.meta').addClass 'tilt-expose'

untilt_map = ->
  $('.map').removeClass 'tilt-up tilt-down'
  $('nav.meta, .upper-nav').removeClass 'tilt-expose'

activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  recess_maps()

deactivate_meta_panes = ->
  clear_map_classes()
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'
  $('div.meta').removeClass 'processed'

activate_upper_nav = ->
  clear_map_classes()
  push_maps_down()
  $('.map-today').removeClass 'tilt-up'
  $('.upper-nav').addClass 'processed'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

deactivate_upper_nav = ->
  clear_map_classes()
  $('.upper-nav').removeClass 'processed'
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

activate_meta_nav = ->
  push_maps_up()
  $('.map-today').removeClass 'tilt-down'
  $('nav.meta').addClass 'processed'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

deactivate_meta_nav = ->
  clear_map_classes()
  $('nav.meta').removeClass 'processed'
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

activate_map_loading_animation = (direction) ->
  $('.map').addClass "load-#{direction}"
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

window.deactivate_map_loading_animation = ->
  $('.map').removeClass 'load-tomorrow load-yesterday'
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

clear_map_classes = ->
  $('.map').removeClass 'recessed down up tilt-up tilt-down'
