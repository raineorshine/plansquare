Db = require('mongodb').Db
async = require('async')

render = require('./controller-helper.js').render
module.exports = (app) ->

  app.get '/', (req, res) ->

    async.waterfall [
      (cb) -> Db.connect(process.env.MONGOLAB_URI, cb),
      (db, cb) -> db.collection('events', cb),
      (coll, cb) -> coll.find().toArray(cb)
      (events) -> 
        viewData =
          title: 'PLANSQUARE'
          bootstrap:
            view: 'index'
            data: 
              events: events

        render req, res, viewData
    ]
