#= require magnific-popup
#= require map_style

{ Map, LatLng, Marker } = google.maps

class Main

  location: new LatLng(19.3609935,-99.1641307)

  constructor: ->
    do @setup_events
    do @setup_map
    $('window, .movie img').load @layout

  setup_events: =>
    $('.movie .text').magnificPopup
      disableOn: 700
      type: 'iframe'
      mainClass: 'mfp-fade'
      removalDelay: 160
      preloader: no
      fixedContentPos: no
    $(window).resize @layout

  setup_map: =>
    @map = new Map $('#map')[0],
      center: @location
      zoom: 13
      styles: window.MAP_STYLE
    @marker = new Marker
      map: @map
      position: @location

  layout: =>
    height = $('.movie').outerHeight()
    $('.item:not(.movie)').css { height }
    @map.setCenter @location

$(document).ready -> window.app = new Main