define([
    'backbone',
  ],
  function(Backbone) {

  var MessageModel = Backbone.Model.extend({
    defaults: {
      from: "",
      message: "",
      date: ""
    },

    urlRoot:"message"

  });

  return MessageModel;

});
