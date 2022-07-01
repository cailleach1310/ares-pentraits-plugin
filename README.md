# ares-pentraits-plugin
A plugin that implements a Pendragon traits system for aresmush.

The Pendragon rpg uses a system of opposing traits that are used to define a character. Under particular circumstances, traits can be checked, and depending on the outcome, a character may behave accordingly. It is a handy tool to use if you want to go with the flow in your rp. In rare cases, staff will ask a trait to be checked during a staff run plot.

Defining traits can be optional. If using the traits system you are not required to set particular traits, this will have you start out with perfectly balanced pairs of traits. Critical successes in particular situations may have you qualify to be considered for a trait raise. Any traits higher than 15 mean a certain fame for that trait and this character. This can only be earned through rp, as traits can't be set higher than 15 in chargen.

## Setting Traits during Chargen
This plugin lets you set your character traits both from the game or the webportal. 

### Client-side 
The commands 'traits' or 'trait/list' show the traits of your character.
You can set / lower / raise your traits during chargen. Please make sure not to exceed the maximum points you can spend to move traits away from the balanced state.

### Webportal-side
You can adjust the your character traits through the button in the Traits tab.

## Checking Traits
You can check traits from the client during rp with the command 'check <trait>'. The check rolls a 20-sided die and compares it to the character's rating.

Possible outcomes:
* success: the roll is lower than the rating.
* fail: the roll is higher than the rating. This will result in a check of the opposing trait.
* critical success: the roll is exactly the value of the rating.
* critical failure: the roll equals '20', this outcome means a critical success for the opposing trait.
  
### Webportal-side
You can check a trait from the live scene menu on the portal.
  
