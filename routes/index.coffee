module.exports = (app) ->

  app.get '/', (req, res) ->
    res.render 'index', title: 'Hoy en la Cineteca'