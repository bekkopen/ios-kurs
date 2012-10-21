define([
    'backbone',
    'modules/message/messageModel'
  ],
  function(Backbone, MessageModel) {

  var MessageCollection = Backbone.Collection.extend({
	model: MessageModel,
    url: "message",

    comparator: function(message) {
    	var date = new Date(message.get('date'));
    	return -date;
    }
  });

  return MessageCollection;

});