define(['backbone', 'modules/message/messagesView', 'modules/message/messageCollection', 'modules/stats/statsView'], function(Backbone, MessagesView, MessageCollection, StatsView) {

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

      var statsView = new StatsView({el: this.sections.stats.$el, collection: messageCollection});
      statsView.render();
      this.sections.stats.show(statsView);

      messageCollection.fetch();

      setInterval(function() {
          messageCollection.fetch();
      }, 0.90 * 1000);
    }
  });

  return Router;

});
