import Component from '@ember/component';
import { action } from '@ember/object';

export default Component.extend({

  @action
  increment() {
    var current = this.rating;
    if (current < 20) {
        this.set('rating',  current + 1);
        this.set('opp_rating',  19 - current);
    }
    this.updated();
  },

  @action
  decrement() {
     var current = this.rating;
     if (current > 0) {
         this.set('rating',  current - 1);
         this.set('opp_rating',  21 - current);
     }
     this.updated();
  }

});
