define(['base/view', 'moment', 'moment_nb', 'underscore', 'text!modules/message/message.html'], function(BaseView, Moment, MomentNB, _, messageTemplate) {

  var MessageView = BaseView.extend({
  	tagName: 'li',
	  className: "message",
    template: messageTemplate,

    render: function() {

      var json = this.model.toJSON();
      var date = Moment(new Date(json.date));
      date = date.fromNow();

      json.date = date;
      json.message = _.escape(json.message);
      json.from = _.escape(json.from);

      this.renderTemplate(json);

      return this;
    }

  });

  return MessageView;
});
