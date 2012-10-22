define(['base/view', 'moment', 'moment_nb', 'text!modules/message/message.html'], function(BaseView, Moment, MomentNB, messageTemplate) {

  var MessageView = BaseView.extend({
  	tagName: 'li',
	  className: "message",
    template: messageTemplate,

    render: function() {

      var json = this.model.toJSON();
      var date = Moment(new Date(json.date));
      date = date.fromNow();
      json.date = date

      this.renderTemplate(json);

      return this;
    }

  });

  return MessageView;
});
