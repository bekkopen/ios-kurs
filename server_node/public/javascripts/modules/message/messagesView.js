define(['base/view', 'modules/message/messageView', 'text!modules/message/messages.html'], function(BaseView, MessageView, messagesTemplate) {

  var MessagesView = BaseView.extend({

    template: messagesTemplate,

    initialize: function(params) {
      this.bindTo(this.collection, "reset", this.render, this);
    },

    render: function() {
      this.renderTemplate();
      this.renderMessages(this.$el.find(".messages"));

      return this;
    },

    renderMessages: function($el) {
      $el.html("");
      var that = this;
      this.collection.each(function(message) {
        var view = that.addSubView(new MessageView({model:message}));
        $el.append(view.render().el);
      });

    }

  });

  return MessagesView;

});
