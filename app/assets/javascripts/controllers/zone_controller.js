App.ZoneController = Ember.ObjectController.extend({
  actions: {
    delete: function() {
      var self = this;
      this.get('model').destroyRecord().then(function() {
        self.transitionToRoute('zones');
      });
    }

  }
});
