import EmberObject, { computed, action } from '@ember/object';
import { A } from '@ember/array';
import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  tagName: '',
  flashMessages: service(),
  gameApi: service(),
  
  didInsertElement: function() {
    this._super(...arguments);
    let self = this;
    this.set('updateCallback', function() { return self.onUpdate(); } );
   },
 
  availableTraitPoints: computed('pen_traits.@each.rating',function() {
    let max = this.get('cg_traits_max_points');
    let list = this.get('pen_traits');
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

  @action
  traitChanged() {
     this.updated();
  },

  @action
  resetTraits(id) {
     let api = this.gameApi;
     api.requestOne('resetTraits', { name: id }, null)
       .then( (response) => {
           if (response.error) {
              return;
           }
           this.flashMessages.success(response.name + "'s traits have been reset!");
       });
  }

});
