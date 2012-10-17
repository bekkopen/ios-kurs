define(['backbone', 'modules/message/messagesView', 'modules/message/messageCollection'], function(Backbone, MessagesView, MessageCollection) {

  var Router = Backbone.Router.extend({

    initialize: function(sections) {
      this.sections = sections;
    },

    routes: {
      '': 'showMessage'
    },

    showMessage: function() {
      var messageCollection = new MessageCollection();
      var messagesView = new MessagesView({el: this.sections.main.$el, collection: messageCollection});
      messagesView.render();
      this.sections.main.show(messagesView);
      messageCollection.fetch();

      //setInterval(function() {
      //    messageCollection.fetch();
      //}, 0.90 * 1000);
    }
  });

  return Router;

});
