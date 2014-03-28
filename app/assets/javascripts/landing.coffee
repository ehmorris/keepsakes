$(window).load ->
  if $('#landingmap').length
    map = L.mapbox.map('landingmap', 'ehmorris.hl0p3291', { zoomControl: false })
    map.dragging.disable()
    map.touchZoom.disable()
    map.doubleClickZoom.disable()
    map.scrollWheelZoom.disable()
    map.setView([42.362, -71.12], 15)
    map.panBy([25000, 25000], {
      'easeLinearity': 1,
      'duration': 200
    })
