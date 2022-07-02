import Component from '@ember/component';

export default Component.extend({
    minRating: 5,
    maxRating: 15,

    actions: {
        increment() {
            var current = this.rating;
            if (current < this.maxRating) {
                this.set('rating',  current + 1);
                this.set('opp_rating',  19 - current);
            }
            this.updated();
        },

        decrement() {
            var current = this.rating;
            if (current > this.minRating) {
                this.set('rating',  current - 1);
                this.set('opp_rating',  21 - current);
            }
            this.updated();
        }

    }
});
