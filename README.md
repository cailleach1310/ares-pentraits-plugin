# ares-pentraits-plugin
A plugin that implements a Pendragon traits system for aresmush.

## Credits
Lyanna @ AresCentral

## Overview
The Pendragon rpg uses a system of opposing traits that are used to define a character. Under particular circumstances traits can be checked, and depending on the outcome, a character may behave accordingly. It can give inspiration to players and add spice to rp, and sometimes lead to scenes departing from prior expectations.

A check is rolled with a 20-sided die, and the result is then compared to the character's rating of the trait. If a trait is checked and fails, the opposing trait will be checked right after. If a check fails critically, it means a critical success of the opposing trait. 

Defining traits can be optional for players. When going with the default (after the first reset), this will have them start out with perfectly balanced pairs of traits. Critical successes in particular situations may qualify for a trait raise after chargen but this will be up to game staff. If a character has any traits higher than 15, this means that this character is famous for that particular trait. 

Visibility of traits in the profile is limited to the character in question and admin. If you want traits to be generally visible, you can easily remove the check in the respective helper file.

This plugin has been developed and tested with aresmush v0.108. It requires some adjustments of custom parts of the code, so that future upgrades usually shouldn't affect this plugin.

### What this plugin covers
* Chargen: Setting traits during chargen, from the game client or from the webportal, including a check for valid traits in the chargen app review.
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
Update with: live-scene-custom-play.js

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

#### shortcuts
'traits' has been defined as shortcut for 'trait/list'. 

## Uninstallation
Removing the plugin requires some code fiddling. See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).

## License
Same as [AresMUSH](https://aresmush.com/license).
