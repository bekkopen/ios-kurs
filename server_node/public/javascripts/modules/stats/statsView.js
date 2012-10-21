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

			_(users).chain()
			.map(function(messages, user) {
				return { name: user, length: messages.length};
			})
			.sortBy(function(user) {
				return -user.length;
			})
			.each(function(user) {
				$el.append("<li><span class='name'>" + user.name + "</span> " + user.length + " meldinger");
			});
		}
	});

	return StatsView;
});