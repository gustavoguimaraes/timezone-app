App.SessionsDestroyRoute = Ember.Route.extend({
  beforeModel: function() {
    App.session.set("token", null);
    this.store.unloadAll("zone");
    this.transitionTo('/');
  }
});