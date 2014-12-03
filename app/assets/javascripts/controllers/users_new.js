App.UsersNewController = Ember.Controller.extend({
  email: '',
  password: '',
  actions: {
    register: function() {
      var account;
      account = {
        user: {
          email: this.get('email'),
          password: this.get('password')
        }
      };
      Ember.$.post('/api/v1/users', account).then((function(_this) {
        return function(response) {
        App.session.set('token', response['token']);
          return _this.transitionToRoute('zones');
        };
      })(this), (function(_this) {
        return function(error) {
          window.ee = error;
          return _this.set('errorMessage', error.responseJSON.errors[0]);
        };
      })(this));
    }
  }
});


