#= require magnific-popup
#= require map_style
#= require page

{ Map, LatLng, Marker } = google.maps

class Main

  cineteca_latlng: new LatLng(19.3609935,-99.1641307)
  map_latlng:  new LatLng(19.3679935,-99.1641307)

  constructor: ->
    do @setup_events
    do @setup_map

  setup_events: =>
    $('window, .movie img').on 'load resize', @layout

  setup_map: =>
    @map = new Map $('#map')[0],
      center: @map_latlng
      zoom: 13
      styles: window.MAP_STYLE
      streetViewControl: no
      mapTypeControl: no
      scrollwheel: no
    @marker = new Marker
      map: @map
      position: @cineteca_latlng
      icon: "http://i.imgur.com/shukrTh.png"

  layout: => @map.panTo @map_latlng

  show: (src) ->
    $.magnificPopup.open
      items: { src, type: 'inline' }
      callbacks: { close: -> page '/' }

  hide: ->
    do $.magnificPopup.close
    do $('#movie').remove


$(document).ready ->

  window.app = new Main

  page '/', -> do app.hide

  page '/:id', (ctx) ->
    movie = $('#movie')
    if movie.data('id') is ctx.params.id
      app.show movie
      movie.empty().remove()
    else
      $.get ctx.path, (data) ->
        app.show $(data).find('#movie')

  do page.start