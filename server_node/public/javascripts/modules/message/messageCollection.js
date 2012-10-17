define([
    'backbone',
    'modules/message/messageModel'
  ],
  function(Backbone, MessageModel) {

  var MessageCollection = Backbone.Collection.extend({
	model: MessageModel,
    url: "message"
  });

  return MessageCollection;

});