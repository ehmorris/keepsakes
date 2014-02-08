$ ->
  $('.activate-meta-nav').on 'click', ->
    activate_meta_nav()
    false

  $('.activate-meta-pane').on 'click', ->
    target = $(@).data('target')
    deactivate_meta_nav()
    activate_meta_pane(".meta.#{target}")
    false

  $('.deactivate-meta-nav').on 'click', ->
    console.log 'test'
    deactivate_meta_nav()
    false

  $('.meta.journal').on 'click', ->
    deactivate_meta_panes()

activate_meta_pane = (pane_class) ->
  # processed as in recessed vs. processed
  $(pane_class).addClass 'processed'
  deactivate_meta_nav()
  $('.map').addClass 'recessed'

deactivate_meta_panes = ->
  $('.map').removeClass 'recessed down'
  $('.meta').removeClass 'processed'

activate_meta_nav = ->
  $('.map').addClass 'down'
  $('nav.meta').addClass 'processed'

deactivate_meta_nav = ->
  $('.map').removeClass 'recessed down'
  $('nav.meta').removeClass 'processed'
