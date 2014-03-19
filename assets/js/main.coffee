#= require magnific-popup
#= require map_style

{ Map, LatLng, Marker } = google.maps

class Main

  cineteca_latlng: new LatLng(19.3609935,-99.1641307)
  map_latlng:  new LatLng(19.3679935,-99.1641307)

  constructor: ->
    do @setup_events
    do @setup_map
    $('window, .movie img').load @layout

  setup_events: =>
    $('.movie .text').magnificPopup
      type: 'ajax'
      mainClass: 'mfp-fade'
      removalDelay: 160
      preloader: no
      showCloseBtn: no
    $(window).resize @layout

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

  layout: =>
    setTimeout =>
      $('#what').css height: $('.movie').outerHeight()
      @map.panTo @map_latlng
    , 50


$(document).ready -> window.app = new Main