// App.Router.reopen({
//   location: 'auto',
//   rootURL: '/'
// });

App.Router.map(function() {
  this.resource('sessions', function() {
    this.route('new');
    this.route('destroy');
  });

  this.resource('zones', function() {
    this.route('new');
  });

  this.resource('zone', {path: '/zones/:id'},function() {
    this.route('edit');
  });

  this.resource('users', function() {
    this.route('new');
  });
});