App.AuthenticatedRoute = Ember.Route.extend({
  beforeModel: function(transition) {
    if (!App.session.get('token')) {
      return this.transitionTo('sessions.new');
    }
  },
  actions: {
    events: {
      error: function(reason, transition) {
        if (reason.status === 401) {
          return this.transitionTo('sessions.new');
        } else {
          return alert('Something went wrong');
        }
      }
    }
  }
});

Session = Ember.Object.extend({
  token: localStorage.token,
  tokenChanged: Ember.observer('token', function() {
    if (this.get('token')) {
      return localStorage.token = this.get('token');
    } else {
      return localStorage.removeItem('token');
    }
  })
});

App.session = Session.create();
