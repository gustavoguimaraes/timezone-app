DS.RESTAdapter.reopen({
  namespace: 'api/v1'
});

App.ApplicationStore = DS.Store.extend({});

App.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  headers: Ember.computed('App.session.token', function() {
    return {
      'AUTHORIZATION': App.session.get("token")
    };
  })
});

