App.ZonesController = Ember.ArrayController.extend({
   init: function() {
        // Update the time.
        this.updateTime();

        // Run other controller setup.
        this._super();
    },

    updateTime: function() {
        var _this = this;

        // Update the time every second.
        Ember.run.later(function() {
            _this.set('localTime', moment().format('h:mm:ss a'));

            _this.get('model').forEach(function(model) {
                model.set('time',
                          moment().tz(model.get('cityName')).format('h:mm:ss a'));
            });

            _this.updateTime();
        }, 1000);
    }.on('init'),

   localTime: new Date().toLocaleTimeString(),

  zones: Ember.computed('search', 'searchedZones', function() {
    if (this.get('search')) {
      return this.get('searchedZones');
    } else {
      return this;
    }
  }),
  searchedZones: Ember.computed('search', function() {
    var search;
    search = this.get('search').toLowerCase();
    return this.filter((function(_this) {
      return function(zone) {
        return zone.get('isOpen') || zone.get('name').toLowerCase().indexOf(search) !== -1;
      };
    })(this));
  })



});