var express = require('express'),
mongoose = require('mongoose'),
colibri = require('colibri'),
routes = require('./routes');

var app = module.exports = express.createServer();

app.configure(function(){
	app.set('views', __dirname + '/views');
	app.set('view engine', 'jade');
	app.set('view options', { pretty: true });
	app.use(express.bodyParser());
	app.use(express.methodOverride());
	app.use(app.router);
	app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('production', function(){
  app.use(express.errorHandler()); 
});

var connectUrl = process.env.MONGOHQ_URL || 'mongodb://localhost/iosCourse'
mongoose.connect(connectUrl);

var MessageSchema = new mongoose.Schema({
  from: {
    type: String
  },
  message: {
    type: String 
  },
  date: {
    type: Date,
    "default": Date.now
  }
});

var MessageModel = mongoose.model('message', MessageSchema);

app.MessageModel = MessageModel

require('./routes/message')(app)

colibri.createResource(app, {
  model: MessageModel,
  hooks: {
    'post': {
      'save': function (req, res, next) {
        app.emit('message', req.rest.document)
        return next(null)
      }

    }
  }
});

app.get('/', routes.index);

var port = process.env.PORT || 3000;

app.listen(port, function() {
  console.log("Listening on " + port);
});

console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);




