# Uninstall instructions

1. Modify the code manually, so that database fields will be properly cleaned up.

* *turn attributes rating and opp_rating into strings.*

      /aresmush/plugins/pentraits/public/pendragon_traits.rb

      module AresMUSH
        class PendragonTraits < Ohm::Model
          include ObjectModel
          reference :character, "AresMUSH::Character"
          attribute :name
          attribute :rating
          attribute :opposite
          attribute :opp_rating
          index :name
        end
      end

* *nil out all attributes*

      /aresmush/plugins/pentraits/public/pentraits_char.rb

      def delete_traits
         self.pen_traits.each do |a|
           a.name = nil
           a.rating = nil
           a.opposite = nil
           a.opp_rating = nil
           a.delete
         end
      end

* *from the game client, 'load pentraits'*
  
  
2. Access the Tinker section on the webportal: Admin -> Tinker

* Add the following to your Tinker handle section:

      def handle
        PenTraits.uninstall_plugin
        Manage.uninstall_plugin("PenTraits")
        client.emit_success "Plugin uninstalled."
      
        rescue Exception => e
        Global.logger.debug "Error loading plugin: #{e}  backtrace=#{e.backtrace[0,10]}"
        client.emit_failure "Error uninstalling plugin: #{e}"
      end

* Click “Save”

* From the game client, run “tinker”

3. Manually remove all plugin's files from your server (and GitHub fork, if applicable), including:

* aresmush/plugins/pentraits  
* aresmush/game/config/pentraits.yml  
* Web portal files - See the /webportal folder in this repo for a specific list of files.  
* Make sure to remove all references in custom code files.  
* Make sure to remove non-custom code parts as well, if you made modifications to the webportal scene system.  

4. Run the load all command.

5. Run the website/deploy command.
