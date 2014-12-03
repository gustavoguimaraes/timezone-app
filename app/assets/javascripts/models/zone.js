App.Zone = DS.Model.extend({
  name: DS.attr('string'),
  cityName: DS.attr('string'),
  minutesOffset: DS.attr('number'),
  gmtTimeDifference: (function() {
    return this.get("minutesOffset") / 60;
  }).property("minutesOffset")
});

App.Zone.reopenClass({

  valid: function(model) {
    return model.name;
  }

});