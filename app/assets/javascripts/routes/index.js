App.IndexRoute = Ember.Route.extend({
  beforeModel: function() {
    if (App.session.get('token')) {
      return this.transitionTo('zones');
    } else {
      return this.transitionTo('sessions.new');
    }
  }
});
