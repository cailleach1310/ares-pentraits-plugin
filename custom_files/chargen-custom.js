import EmberObject, { computed } from '@ember/object';
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
 
  onUpdate: function() {
    return {
      pen_traits: this.createTraitHash(this.get('char.custom.pen_traits'))
    };
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
// lots of stuff to be added here later!
    this.set('charErrors', A());
  },
    
  @action
  traitChanged() {
     this.validateChar();
  }

});
