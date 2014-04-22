$ ->
  $('.loading-text').addClass 'show'
  setTimeout ->
    $('.loading-text').removeClass 'show'
  , 1800

  $(document).on
    mouseenter: recess_maps
    mouseleave: clear_map_classes
  , '.yesterday-link, .tomorrow-link'

  $(document).on
    mouseenter: tilt_map_up
    mouseleave: untilt_map
  , '.activate-upper-nav'

  $(document).on
    mouseenter: tilt_map_down
    mouseleave: untilt_map
  , '.activate-meta-nav'

  $('.activate-upper-nav').on 'click', activate_upper_nav

  $('.deactivate-upper-nav').on 'click', deactivate_upper_nav

  $('.activate-meta-nav').on 'click', activate_meta_nav

  $('.deactivate-meta-nav').on 'click', deactivate_meta_nav

  $('.activate-meta-pane').on 'click', ->
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

activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  recess_maps()

window.deactivate_meta_panes = ->
  clear_map_classes()
  $('.yesterday-link, .tomorrow-link').removeClass 'hide'
  $('div.meta').removeClass 'processed'

activate_upper_nav = ->
  push_maps_down()
  scroll_to_center('.calendar')
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

activate_day_loading_animation = (direction, loading_text) ->
  deactivate_upper_nav()
  $('.map').addClass "load-#{direction}"
  $('.loading-text span').text(loading_text).parent().addClass 'show pulse'
  $('.yesterday-link, .tomorrow-link').addClass 'hide'

window.deactivate_day_loading_animation = ->
  clear_map_classes()
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

clear_map_classes = ->
  $('.map').removeClass 'recessed down up tilt-up tilt-down load-tomorrow load-yesterday'

scroll_to_center = (container) ->
  $(container).scrollLeft(
    ($(container).get(0).scrollWidth / 2) - ($(container).width() / 2))
