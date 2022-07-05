import EmberObject, { computed } from '@ember/object';
import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
    gameApi: service(),
    flashMessages: service(),
    tagName: '',
    selectTraitCheck: false,
    pcCheckTrait: null,
    pcCheckName: null,
    checkString: null,
    destinationType: 'scene',

    didInsertElement: function() {
      this._super(...arguments);
      let defaultTrait = this.pentraits ? this.pentraits[0] : '';
      this.set('checkString', defaultTrait);
    },


    actions: { 
      
      addCheck() {
        let api = this.gameApi;
        let defaultTrait = this.pentraits ? this.pentraits[0] : '';
      
        // Needed because the onChange event doesn't get triggered when the list is 
        // first loaded, so the roll string is empty.
        let checkString = this.checkString || defaultTrait;
        let pcCheckTrait = this.pcCheckTrait;
        let pcCheckName = this.pcCheckName;
        
        var sender;
        if (this.scene) {
          sender = this.get('scene.poseChar.name');
        }
          
        if (!checkString && !pcCheckTrait) {
          this.flashMessages.danger("You haven't selected a trait to check.");
          return;
        }
      
        if (pcCheckTrait || pcCheckTrait) {
          if (!pcCheckTrait || !pcCheckName) {
            this.flashMessages.danger("You have to provide all trait information to add a check for a PC.");
            return;
          }
        }
        this.set('selectTraitCheck', false);
        this.set('checkString', null);
        this.set('pcCheckName', null);
        this.set('pcCheckTrait', null);

        var destinationId, command;
        if (this.destinationType == 'scene') {
          destinationId = this.get('scene.id');
          command = 'addSceneCheck';
        }
        else {
          destinationId = this.get('job.id');
          command = 'addJobTrait'
        }
        
        api.requestOne(command, { id: destinationId,
           check_string: checkString,
           pc_name: pcCheckName,
           pc_trait: pcCheckTrait,
           sender: sender }, null)
        .then( (response) => {
          if (response.error) {
            return;
          }
        });
      },
    }
});
