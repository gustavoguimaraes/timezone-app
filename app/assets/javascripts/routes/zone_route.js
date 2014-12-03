App.ZoneRoute = Ember.Route.extend({
  model: function(params){
    console.log('zone', params);
    return this.store.find('zone', params.id);
  }
});