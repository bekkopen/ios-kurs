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


mongoose.connect('mongodb://localhost/colibriTodo');

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

colibri.createResource(app, {
  model: MessageModel
});

app.get('/', routes.index);

var port = process.env.PORT || 3000;

app.listen(port, function() {
  console.log("Listening on " + port);
});

console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);




