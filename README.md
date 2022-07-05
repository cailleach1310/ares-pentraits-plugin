# ares-pentraits-plugin
A plugin that implements a Pendragon traits system for aresmush.

## Credits
Lyanna @ AresCentral

## Overview
The Pendragon rpg uses a system of opposing traits that define a character. Under particular circumstances traits can be checked, and depending on the outcome, a character may behave accordingly. It can give inspiration to players and add spice to rp, and sometimes lead to scenes departing from prior expectations.

A check is rolled with a 20-sided die, and the result is then compared to the character's rating of the trait. If a trait is checked and fails, the opposing trait will be checked right after. If a check fails critically, it means a critical success of the opposing trait. 

Defining traits can be optional for players. When going with the default (after the first reset), this will have them start out with perfectly balanced pairs of traits. Critical successes in particular situations may qualify for a trait raise after chargen but this will be up to game staff. If a character has any traits higher than 15, this means that this character is famous for that particular trait. 

This plugin has been developed and tested with aresmush v0.108. Necessary adjustments are limited to custom parts of the code, so that future aresmush upgrades usually won't affect this plugin.

If you want to have a working traits dropdown in the live-scene view on the webportal, however, you'll have to adjust non-custom code parts, namely the scene-live route and the scene-live template. This may need some extra checking and adjustments when upgrading your aresmush version. The plugin will work without these adjustments, but you'll have to type the traits into the input box. The (optional) adjustments are explained below.

### What this plugin covers
* Chargen: Setting traits during chargen, from the game client or from the webportal, including a check for valid trait settings in the chargen app review.
* Profile: Traits are part of the webportal character profile.
* Staff-side setting of character traits through the trait/set command on the game client.
* Staff-side post chargen raising of traits from the webportal through the chargen option on a char page.
* Awarding achievements for checking a trait for the first time and for the first critical trait check.
* Checking traits from the game client and/or from the webportal's live scene menu.

## Screenshots
### Game Client - Traits View
![trait-list](/images/traits_client.PNG)

Use the 'traits' or 'trait/list' command to view your character traits.

### Game Client - Checking Traits
![check-trait-client](/images/trait_check_client.PNG)

### Webportal - Profile View
![profile-traits](/images/profile_traits.PNG)

### Webportal - Checking Traits
![checking-traits-web](/images/webportal_trait_check.PNG)

## Installation
In the game, run: plugin/install https://github.com/cailleach1310/ares-pentraits-plugin

### Updating Custom Files
If you do not have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for the pentraits plugin.

#### aresmush/plugins/profile/custom_char_fields.rb
Update with: custom_files/custom_char_fields.rb

#### aresmush/plugins/chargen/custom_app_review.rb
Update with: custom_files/custom_app_review.rb

#### ares-webportal/app/components/chargen-custom.js
Update with: custom_files/chargen-custom.js

#### ares-webportal/app/templates/components/chargen-custom.hbs
Update with: custom_files/chargen-custom.hbs

#### ares-webportal/app/templates/components/chargen-custom-tabs.hbs
Update with: custom_files/chargen-custom-tabs.hbs

#### ares-webportal/app/templates/components/profile-custom.hbs
Update with: custom_files/profile-custom.hbs

#### ares-webportal/app/templates/components/profile-custom-tabs.hbs
Update with: custom_files/profile-custom-tabs.hbs

#### ares-webportal/app/templates/components/live-scene-custom-play.hbs
Update with: custom_files/live-scene-custom-play.hbs

#### ares-webportal/app/components/live-scene-custom-play.js
Update with: custom_files/live-scene-custom-play.js

### Optional Adjustments of Non-Custom Code Parts
To enable a dropdown list of trait names for trait checks in the live-scene view of the webportal you will need to adjust the following non-custom parts of code. Please be aware that future upgrades might be more work, as you might have to add these code parts manually back in after an upgrade. 

#### ares-webportal/routes/scene-live.js
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

#### ares-webportal/app/templates/scene-live.hbs
Add the pentraits parameter to the call of live-scene-control component:

      <LiveSceneControl @scene={{this.model.scene}} @locations={{this.model.locations}} @abilities={{this.model.abilities}} @pentraits={{this.model.pentraits}} @places>

#### ares-webportal/app/templates/components/live-scene-control.hbs
Replace abilities in the call of the live-scene-custom-play component with the pentraits parameter:

      <LiveSceneCustomPlay @pentraits={{this.pentraits}} @scene={{this.scene}} />


## Configuration

### Other Plugins
Configuration files of other plugins can be adjusted to make life easier. Suggestions can be found below.

#### aresmush/game/config/achievements.yml
You can configure trait achievements to show the same icon as fs3 achievements. 

     types:
       trait: fa-cubes

#### aresmush/game/config/chargen.yml
For those going through chargen on the game client, it is necessary to add a chargen stage for traits.

    traits_blurb: |-
      %xctrait/list%xn shows your traits.
      %xctrait/set <trait>=<value>%xn lets you set a trait directly.
      %xctrait/raise <trait>%xn and %xctrait/lower <trait>%xn are another way of changing your trait values.
      %xctrait/points will show you how many points you have spent.
      %xctrait/reset%xn resets your traits to a balanced state. Do this first!
    stages:
      traits:
        title: Traits
        text: |-
            Setting particular character traits is optional, but you'll have to at least do a %xctraits/reset%xn to set them in a balanced state. They are a way you can use to give more depth to the character, and also explore reactions of your character by checking a trait.

            Checking a trait in game can add more flavor, and sometimes might go against your character's interest. But it will always be up to you, the player, to interpret the result of a check in a way that is comfortable for you.

          %xctrait/list%xn shows your traits.
          %xctrait/set <trait>=<value>%xn lets you set a trait directly.
          %xctrait/raise <trait>%xn and %xctrait/lower <trait>%xn are another way of changing your trait values.
          %xctrait/points%xn will show you how many points you have spent.
          %xctrait/reset%xn resets your traits to a balanced state. Do this first!

### PenTraits Configuration 
The pentraits.yml comes with a default configuration that can be adjusted to your needs. The keys are explained below:

#### achievements
The plugin comes with two predefined trait achievements, 'checked_trait' and 'critical_check'. 

#### min_rating
The minimum value for a trait in chargen, per default 5.

#### max_rating
The maximum value for a trait in chargen, per default 15. 

#### traits
The plugin comes with the standard Pendragon rpg traits, but you can actually configure your own pairs of traits here.  

#### trait_points
Trait points for chargen, per default 10.

#### trait_visibility
Here you can toggle whether traits are visible for other players in the web profile. Per default, this is set to "false".

#### shortcuts
'traits' has been defined as shortcut for 'trait/list'. 

## Uninstallation
Removing the plugin requires some code fiddling. See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).

## License
Same as [AresMUSH](https://aresmush.com/license).
