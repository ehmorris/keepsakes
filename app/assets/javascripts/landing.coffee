$(window).load ->
  if $('#landingmap').length
    map = L.mapbox.map('landingmap', 'ehmorris.hl0p3291', { zoomControl: false })
    map.dragging.disable()
    map.touchZoom.disable()
    map.doubleClickZoom.disable()
    map.scrollWheelZoom.disable()
    map.setView([42.362, -71.12], 15)
    map.panBy([10000, 10000], {
      'easeLinearity': 1,
      'duration': 500
    })

  $('.sign-up-flow form input[type=button]').on 'click', ->
    $('.sign-up-flow form input').hide()
    $('.sign-up-flow form .confirm').fadeIn()
    $('.sign-up-flow .success').fadeIn()
