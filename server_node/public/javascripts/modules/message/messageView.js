define(['base/view', 'text!modules/message/message.html'], function(BaseView, messageTemplate) {

  var MessageView = BaseView.extend({
  	tagName: 'li',
	  className: "message",
    template: messageTemplate,

    render: function() {
      this.renderTemplate(this.model.toJSON());

      return this;
    }

  });

  return MessageView;
});
