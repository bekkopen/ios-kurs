define(['base/view', 'text!modules/stats/stats.html'], function(BaseView, statsTemplate) {

	var StatsView = BaseView.extend({
		template: statsTemplate,

		initialize: function(options) {
			this.bindTo(this.collection, 'reset', this.render, this);
		},

		render: function() {
			this.renderTemplate();
			this.renderStats(this.$el.find('.stats'));
			return this;
		},

		renderStats: function($el) {
			$el.html("");
			var users = this.collection.groupBy(function(message) {
				return message.get("from");
			});

			_(users).each(function(messages, user) {
				$el.append("<li><span class='name'>" + user + "</span>: " + messages.length + " meldinger");
			});
		}
	});

	return StatsView;
});