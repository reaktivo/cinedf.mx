{ get } = require 'request'
{ findWhere, last } = require 'underscore'
StreamCache = require 'stream-cache'
cache = new StreamCache

prefix = 'http://www.cinetecanacional.net'

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

  app.get '/imagenes/*', (req, res, next) ->
    if cache(req.path)
      console.log 'mem'
      cache(req.path).pipe(res)
    else
      console.log 'load'
      stream = cache(req.path, new StreamCache)
      get(prefix + req.path).pipe stream
      stream.pipe res
