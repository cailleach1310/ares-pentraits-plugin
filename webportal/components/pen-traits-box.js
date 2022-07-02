import Component from '@ember/component';

export default Component.extend({
    actions: {
        increment() {
            var current = this.rating;
            if (current < 20) {
                this.set('rating',  current + 1);
                this.set('opp_rating',  19 - current);
            }
            this.updated();
        },

        decrement() {
            var current = this.rating;
            if (current > 0) {
                this.set('rating',  current - 1);
                this.set('opp_rating',  21 - current);
            }
            this.updated();
        }

    }
});
