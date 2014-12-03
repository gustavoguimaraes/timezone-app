App.ZonesRoute = App.AuthenticatedRoute.extend({
  model: function() {
    return this.store.find('zone');
  }
});
