import Component from '@ember/component';
import EmberObject, { computed } from '@ember/object';
import { A } from '@ember/array';
import { inject as service } from '@ember/service';

export default Component.extend({
  tagName: '',
  gameApi: service(),

  didInsertElement: function() {
    this._super(...arguments);
    let self = this;
    this.set('updateCallback', function() { return self.onUpdate(); } );
  },

  availableTraitPoints: computed('char.custom.pen_traits.@each.rating',function() {
    let max = this.get('char.custom.cg_traits_max_points');
    let list = this.get('char.custom.pen_traits');
    let spent = this.countTraitPoints(list);
    let available = max - spent;
    return available;
  }),

  countTraitPoints: function(list) {
    if (!list) {
      return;
    }
    let points = 0;
    list.forEach(function (trait) {
      let diff = 10 - trait.rating;
      if (diff < 0) {
         diff = -diff
      }
      points = points + diff;
   });
    return points;
  },

  onUpdate: function() {
    // Return a hash containing your data.  Character data will be in 'char'.  For example:
    // 
    return { pen_traits: this.createTraitHash(this.get('char.custom.pen_traits')) }
  },

  createTraitHash: function(traitlist) {
    if (!traitlist) {
      return {};
    }
    return traitlist.reduce(function(map, obj) {
      if (obj.name && obj.name.length > 0) {
        map[obj.name] = obj.rating;
      }
      return map;
    },
    {}

    );
  },

  validateChar: function() {
    this.set('charErrors', A());
    let maxTraits = this.get('char.custom.cg_traits_max_points');
    let traits = this.get('char.custom.pen_traits')
    let totalTraits = this.countTraitPoints(traits);
    if (totalTraits > maxTraits) {
      this.charErrors.pushObject('You can only spend ${maxTraits} points in action skills. You have spent ${totalTraits}.');
    }
  },

  actions: {
      traitChanged() {
        this.validateChar();
      },
      resetTraits(id) {
        let api = this.gameApi;
        api.requestOne('resetTraits', { name: id }, null)
            .then( (response) => {
                if (response.error) {
                    return;
                }
                this.flashMessages.success(response.name + "'s traits have been reset!");
            });
       }}

});
