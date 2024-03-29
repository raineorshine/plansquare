// Generated by CoffeeScript 1.4.0
(function() {
  var Db, async, render;

  Db = require('mongodb').Db;

  async = require('async');

  render = require('./controller-helper.js').render;

  module.exports = function(app) {
    return app.get('/', function(req, res) {
      return async.waterfall([
        function(cb) {
          return Db.connect(process.env.MONGOLAB_URI, cb);
        }, function(db, cb) {
          return db.collection('events', cb);
        }, function(coll, cb) {
          return coll.find().toArray(cb);
        }, function(events) {
          var viewData;
          viewData = {
            title: 'PLANSQUARE',
            bootstrap: {
              view: 'index',
              data: {
                events: events
              }
            }
          };
          return render(req, res, viewData);
        }
      ]);
    });
  };

}).call(this);
