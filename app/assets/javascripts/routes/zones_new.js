App.ZonesNewRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    this._super(controller, model);
    controller.set('zone', this.modelFor('zone'));
    controller.set('selectedTimezone', '');
    controller.set('name', '');
    controller.set('showError', false);
  },

  activate:   function() { this.controllerFor('zones').set('isNew', true) ;},
  deactivate: function() { this.controllerFor('zones').set('isNew', false) ;}
});