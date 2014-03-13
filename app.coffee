x = require 'express'
{ join } = require 'path'
load = require 'express-load'
assets = require 'connect-assets'
cineteca = require 'cineteca'

app = do x

app.set 'port', process.env.PORT or 3000
app.set 'views', join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use x.favicon()
app.use x.logger('dev')
app.use x.json()
app.use x.urlencoded()
app.use x.methodOverride()
app.use assets(helperContext: app.locals)
app.use app.router
app.use x.static(join(__dirname, 'public'))

if 'development' is app.get('env')
  app.use x.errorHandler()

load 'routes'
  .into app

app.locals.movies = []

get_showtimes = ->
  console.log 'Loading movie showtimes'
  cineteca.today (err, movies) ->
    app.locals.movies = movies
    console.log 'Finished loading movie showtimes'

# Reload movies eveery half hour
setInterval get_showtimes, 1000 * 60 * 30

# Do first load
do get_showtimes

app.listen app.get('port'), ->
  console.log "Server listening on port #{app.get('port')}"
