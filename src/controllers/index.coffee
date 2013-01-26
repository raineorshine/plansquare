render = require('./controller-helper.js').render
module.exports = (app) ->

  app.get '/', (req, res) ->
    viewData =
      title: 'PLANSQUARE'
      bootstrap:
        view: 'index'
        data: 
          events: [
            {
              title: 'NodeConf 2013'
              start: '6-27-13',
              end: '6-30-13',
              type: 'coding'
            },
            {
              title: 'Enlightened Society Assembly'
              start: '7-6-13',
              end: '7-21-13',
              type: 'meditation'
            },
            {
              title: 'Buddhist Geeks 2013'
              start: '8-16-13',
              end: '8-18-13',
              type: 'meditation'
            }
          ]

    render req, res, viewData
