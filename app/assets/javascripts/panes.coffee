$ ->
  $('.activate-meta-nav').hover ->
    $('.map-today').addClass 'tilt'
  , ->
    $('.map-today').removeClass 'tilt'

  $('.activate-meta-nav').on 'click', ->
    activate_meta_nav()

  $('.activate-meta-pane').on 'click', ->
    target = $(@).data('target')
    deactivate_meta_nav()
    activate_meta_pane(".meta.#{target}")
    false

  $('.deactivate-meta-nav').on 'click', ->
    deactivate_meta_nav()

  $('.meta.journal').on 'click', ->
    deactivate_meta_panes()

  $('.yesterday-link, .tomorrow-link').hover ->
    $(this).addClass 'hint'
    recess_maps()
  , ->
    $(this).removeClass 'hint'
    clear_map_classes()


activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  recess_maps()

deactivate_meta_panes = ->
  clear_map_classes()
  $('.meta').removeClass 'processed'

activate_meta_nav = ->
  $('.map-today').removeClass 'tilt'
  push_maps_down()
  $('nav.meta').addClass 'processed'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

deactivate_meta_nav = ->
  clear_map_classes()
  $('nav.meta').removeClass 'processed'
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

clear_map_classes = ->
  $('.map').removeClass 'recessed down'
