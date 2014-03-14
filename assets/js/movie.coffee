
# class Main
#
#   cineteca_latlng: new LatLng(19.3609935,-99.1641307)
#   map_latlng:  new LatLng(19.3679935,-99.1641307)
#
#   constructor: ->
#     do @setup_events
#     do @setup_map
#     $('window, .movie img').load @layout
#
#   setup_events: =>
#     $('.movie .text').magnificPopup
#       disableOn: 700
#       type: 'iframe'
#       mainClass: 'mfp-fade'
#       removalDelay: 160
#       preloader: no
#       fixedContentPos: no
#     $(window).resize @layout
#
#   setup_map: =>
#     @map = new Map $('#map')[0],
#       center: @map_latlng
#       zoom: 13
#       styles: window.MAP_STYLE
#       streetViewControl: no
#       mapTypeControl: no
#       scrollwheel: no
#     @marker = new Marker
#       map: @map
#       position: @cineteca_latlng
#       icon: "http://i.imgur.com/shukrTh.png"
#
#   layout: =>
#     height = $('.movie').outerHeight()
#     height *= 2 if height < 200
#     $('.item:not(.movie)').css { height }
#     @map.setCenter @map_latlng
#
# $(document).ready -> window.app = new Main