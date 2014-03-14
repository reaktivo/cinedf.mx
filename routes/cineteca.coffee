{ get } = require 'request'
{ findWhere, last } = require 'underscore'
StreamCache = require 'stream-cache'
cache = new StreamCache
cineteca = require 'cineteca'

max_images = 24
memory = []

cache = (path, stream) ->
  if stream
    memory.push { path, stream }
    memory.shift() if memory.length > max_images
    console.log memory.length
    last(memory).stream
  else
    c = findWhere memory, { path }
    if c then c.stream

module.exports = (app) ->

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

  app.get '/imagenes/*', (req, res, next) ->
    if cache(req.path)
      console.log 'mem'
      cache(req.path).pipe(res)
    else
      console.log 'load'
      stream = cache(req.path, new StreamCache)
      get(cineteca.prefix + req.path).pipe stream
      stream.pipe res
