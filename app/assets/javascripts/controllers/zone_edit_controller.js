App.ZoneEditController = Ember.ObjectController.extend({
 /* create array of timezones with name & offset */
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
        /* save a timezone record*/
        add: function() {
          var timezone = this.store.update('zone', {
            id: this.get('model.id'),
            cityName: this.get('selectedTimezone').cityName,
            minutesOffset: this.get('selectedTimezone').minutesOffset
          });
          timezone.save();

          this.transitionToRoute('zone');



        },
        cancel: function() {
              this.get('model').rollback();
              this.transitionToRoute('zone');
            }
      }

});