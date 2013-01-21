var mongoose = require('mongoose')

module.exports = function(app) {

  app.get('/message', function (req, res, next) {
    var isStream = (req.query.feed == 'continuous')
      , isFirst = true
      , sep

    function ondoc(doc) {
      try {
        doc = JSON.stringify(doc)
      } catch(e) {
        console.error(e)
        return
      }

      if (isFirst) {
        isFirst = false
      } else {
        res.write(sep)
      }

      res.write(doc)
    }


    if (isStream) {
      sep = '\r\n'
      res.setHeader('Content-Type', 'application/x-json-stream')

      app.on('message', ondoc)

      res.on('close', function () {
        app.removeListener('message', ondoc)
      })

    } else {
      sep = ',\r\n'
      res.setHeader('Content-Type', 'application/json')
      res.write('[')
    }


    var query = {}
      , since
    if (req.query.since) {
      try {
        since = new mongoose.Types.ObjectId(req.query.since)
      } catch(e) {
        return next(new Error('Invalid ObjectID for `since` query param'))
      }
      query._id = { $gt: since }
    }

    var stream = app.MessageModel.find(query).stream()
    stream.on('data', ondoc)

    if (!isStream) {
      stream.on('end', function () {
        res.end(']')
      })
    }
  })

}
