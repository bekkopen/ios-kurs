require.config({
  'paths': { 
    "jquery": "libs/jquery",
    "underscore": "libs/underscore", 
    "backbone": "libs/backbone",
    "text": "libs/text",
    "moment": "libs/moment",
    "moment_nb": "libs/moment_nb"
  },
  shim: {
    'underscore': {
      exports: '_'
    },
    'backbone': {
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    }
  }
}); 

define(['app', 'jquery'], function (App, $) {

  var app = new App($("body"));

  app.addSections({
    "main": "#main",
    "stats": "#stats"
  });

  app.run();

});

