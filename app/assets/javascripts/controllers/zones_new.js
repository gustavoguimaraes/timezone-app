App.ZonesNewController = Ember.ObjectController.extend({
    init: function() {
        var timezones = [];
        for (var i in moment.tz._zones) {
          timezones.push({
            cityName: moment.tz._zones[i].name,
            minutesOffset: moment.tz._zones[i].offsets[0]

          });
        }
        this.set('zones', timezones);
        this._super();
      },
      selectedTimezone: null,
      actions: {
        add: function() {
          var fields = this.get('model');

          if (App.Zone.valid(fields)) {

            var timezone = this.store.createRecord('zone', {
              name: this.get('model').name,
              cityName: this.get('selectedTimezone').cityName,
              minutesOffset: this.get('selectedTimezone').minutesOffset
            });

            timezone.save();
            this.transitionToRoute('zones');
          } else {
            this.set('showError', true);
          }

          },
        /* delete a timezone record from our offline datastore */
        cancel: function() {
          this.transitionToRoute('zones');
        }
      }
});