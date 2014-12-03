App.UsersNewRoute = Ember.Route.extend({
  setupController: function(controller) {
    this.controller.set('email', null);
    this.controller.set('password', null);
    this.controller.set('errorMessage', null);
  }
});
