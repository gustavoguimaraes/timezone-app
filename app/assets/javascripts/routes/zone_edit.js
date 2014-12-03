App.ZoneEditRoute = Ember.Route.extend({
  activate:   function() { this.controllerFor('zone').set('isEditing', true) ;},
  deactivate: function() { this.controllerFor('zone').set('isEditing', false) ;}
});
