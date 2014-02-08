$ ->
  $('.activate-meta-nav').on 'click', ->
    activate_meta_nav()
    false

  $('.activate-meta-pane').on 'click', ->
    target = $(@).data('target')
    deactivate_meta_nav()
    activate_meta_pane(".meta.#{target}")
    false

  $('.close-meta-nav').on 'click', ->
    deactivate_meta_nav()
    false

activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  $('.map').addClass 'recessed'

activate_meta_nav = ->
  $('.map').addClass 'down'
  $('.activate-meta-nav').addClass 'invisible'

deactivate_meta_nav = ->
  $('.map').removeClass 'recessed down'
  $('.activate-meta-nav').removeClass 'invisible'
