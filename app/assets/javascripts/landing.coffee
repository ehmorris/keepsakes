$(window).load ->
  $('.sign-up-flow form input[type=button]').on 'click', ->
    $('.sign-up-flow form input').hide()
    $('.sign-up-flow form .confirm').fadeIn()
    $('.sign-up-flow .success').fadeIn()
