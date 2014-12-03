App.SessionsNewController = Ember.Controller.extend({
  actions: {
    signIn: function() {
      var credentials;
      credentials = {
        user: {
          email: this.get('email'),
          password: this.get('password')
        }
      };
      Ember.$.post('/api/v1/sessions', credentials).then((function(_this) {
        return function(response) {
        App.session.set('token', response['token']);
          return _this.transitionToRoute('zones');
        };
      })(this), (function(_this) {
        return function(error) {
          return _this.set('errorMessage', error.responseJSON.message);
        };
      })(this));
    }
  }
});