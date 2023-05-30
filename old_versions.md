## Optional Adjustments of Non-Custom Code Parts (older versions of AresMUSH, before v1.0.6)
From v.1.0.6 onwards, the dropdown list of trait names in the live-scene view of the webportal to select from is already enabled. It's handled in the files pertaining to custom scene data (see above). If you are using an older version of AresMUSH, you'd have to adjust the following non-custom parts of code to achieve the same thing. This is not mandatory. You can still check traits from the webportal, but you'd have to type the trait name into the box. Please be aware that future upgrades might be more work, as you might have to review and adjust these code parts manually after an upgrade. 

### ares-webportal/routes/scene-live.js
Add the pentraits parameter to the RVSP hash that is used for creating the model:

     model: function(params) {
        let api = this.gameApi;
        return RSVP.hash({
             scene: api.requestOne('liveScene', { id: params['id'] }),
             abilities: api.request('charAbilities', { id: this.get('session.data.authenticated.id') }),
             pentraits: api.request('penTraits'),
             locations: api.request('sceneLocations', { id: params['id'] })
           })
           .then((model) =>  {
             
             if (model.scene.shared) {
               this.router.transitionTo('scene', params['id']);             
             }
             else
             {
               return EmberObject.create(model);
             }
         });
    },

### ares-webportal/app/templates/scene-live.hbs
Add the pentraits parameter to the call of live-scene-control component:

      <LiveSceneControl @scene={{this.model.scene}} @locations={{this.model.locations}} @abilities={{this.model.abilities}} @pentraits={{this.model.pentraits}} @places>

### ares-webportal/app/templates/components/live-scene-control.hbs
Replace abilities in the call of the live-scene-custom-play component with the pentraits parameter:

      <LiveSceneCustomPlay @pentraits={{this.pentraits}} @scene={{this.scene}} />

