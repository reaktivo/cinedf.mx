{ findWhere } = require 'underscore'

module.exports = (app) ->

  app.get '/', (req, res, next) ->
    res.render 'index', title: 'Hoy en la Cineteca'

  app.get '/:id', (req, res, next) ->
    movie = findWhere app.locals.movies, id: req.params.id
    return do next unless movie
    res.render 'movie',
      title: "#{movie.title} — Hoy en la Cineteca"
      movie: movie
