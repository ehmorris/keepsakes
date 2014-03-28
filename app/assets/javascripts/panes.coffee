$ ->
  $('.activate-meta-nav').hover ->
    $('.map-today').addClass 'tilt'
  , ->
    $('.map-today').removeClass 'tilt'

  $('.activate-meta-nav').on 'click', ->
    window.activate_meta_nav()

  $('.activate-meta-pane').on 'click', ->
    target = $(@).data('target')
    window.deactivate_meta_nav()
    window.activate_meta_pane(".meta.#{target}")
    false

  $('.deactivate-meta-nav').on 'click', ->
    window.deactivate_meta_nav()

  $('.meta.journal, .meta.detail').on 'click', ->
    window.deactivate_meta_panes()

  $('.yesterday-link, .tomorrow-link').hover ->
    $(this).addClass 'hint'
    window.recess_maps()
  , ->
    $(this).removeClass 'hint'
    window.clear_map_classes()


window.activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  recess_maps()

window.deactivate_meta_panes = ->
  clear_map_classes()
  $('.meta').removeClass 'processed'

window.activate_meta_nav = ->
  $('.map-today').removeClass 'tilt'
  push_maps_down()
  $('nav.meta').addClass 'processed'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

window.deactivate_meta_nav = ->
  clear_map_classes()
  $('nav.meta').removeClass 'processed'
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

window.recess_maps = ->
  $('.map-today').addClass 'recessed'
  if $('.tomorrow-link').length
    $('.map-tomorrow').addClass 'recessed'
  if $('.yesterday-link').length
    $('.map-yesterday').addClass 'recessed'

window.push_maps_down = ->
  $('.map-today').addClass 'down'
  if $('.tomorrow-link').length
    $('.map-tomorrow').addClass 'down'
  if $('.yesterday-link').length
    $('.map-yesterday').addClass 'down'

window.clear_map_classes = ->
  $('.map').removeClass 'recessed down'
