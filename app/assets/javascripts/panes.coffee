$ ->
  $('.yesterday-link, .tomorrow-link').hover ->
    $(this).addClass 'hint'
    window.recess_maps()
  , ->
    $(this).removeClass 'hint'
    window.clear_map_classes()

  $('.activate-settings-nav').hover ->
    $('.map-today').addClass 'tilt-up'
  , ->
    $('.map-today').removeClass 'tilt-up'

  $('.activate-meta-nav').hover ->
    $('.map-today').addClass 'tilt-down'
  , ->
    $('.map-today').removeClass 'tilt-down'

  $('.activate-settings-nav').on 'click', ->
    window.activate_settings_nav()

  $('.deactivate-settings-nav').on 'click', ->
    window.deactivate_settings_nav()

  $('.activate-meta-nav').on 'click', ->
    window.activate_meta_nav()

  $('.deactivate-meta-nav').on 'click', ->
    window.deactivate_meta_nav()

  $('.activate-meta-pane').on 'click', ->
    target = $(@).data('target')
    window.deactivate_settings_nav()
    window.activate_meta_pane(".meta.#{target}")
    false

  $('div.meta').on 'click', ->
    window.deactivate_meta_panes()

  # cancel out window deactivation when clicking on things inside the pane
  $('.meta.detail img, .meta.detail video'). on 'click', ->
    false

window.activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  recess_maps()

window.deactivate_meta_panes = ->
  clear_map_classes()
  $('div.meta').removeClass 'processed'
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

window.activate_settings_nav = ->
  $('.map-today').removeClass 'tilt-up'
  push_maps_down()
  $('nav.settings').addClass 'processed'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

window.deactivate_settings_nav = ->
  clear_map_classes()
  $('nav.settings').removeClass 'processed'
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'

window.activate_meta_nav = ->
  $('.map-today').removeClass 'tilt-down'
  push_maps_up()
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

window.push_maps_up = ->
  $('.map-today').addClass 'up'
  if $('.tomorrow-link').length
    $('.map-tomorrow').addClass 'up'
  if $('.yesterday-link').length
    $('.map-yesterday').addClass 'up'

window.clear_map_classes = ->
  $('.map').removeClass 'recessed down up'
