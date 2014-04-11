$(window).load ->
  $('body > div a').on 'click', ->
    $(@).parent().removeClass('active')
    if $(@).parent().next().length > 0
      $(@).parent().next().addClass('active')
    false

  $('.sign-up-flow form input[type=button]').on 'click', ->
    $('.sign-up-flow form input').hide()
    $('.sign-up-flow form .confirm').fadeIn()
    $('.sign-up-flow .success').fadeIn()
