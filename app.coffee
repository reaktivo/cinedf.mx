x = require 'express'
{ join } = require 'path'
load = require 'express-load'
assets = require 'connect-assets'
nudist = require 'nudist'

app = do x

app.set 'port', process.env.PORT or 3000
app.set 'views', join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use nudist 'cinedf.mx'
app.use x.favicon join __dirname, 'public', 'favicon.ico'
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

app.listen app.get('port'), ->
  console.log "Server listening on port #{app.get('port')}"
