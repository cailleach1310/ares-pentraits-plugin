module AresMUSH
  module PenTraits
        
    # Rolls a 20-sided die and returns the result.
    def self.roll
      return rand(1..20)
    end
    
    def self.get_trait_rating(char, name)
        if PenTraits.positives.include? name
          trait_name = name
          trait = PenTraits.find_trait(char, name)
          trait_rating = trait.rating
        else
          trait_name = PenTraits.get_opp_trait(name)
          trait = PenTraits.find_trait(char, trait_name)
          if trait
             trait_rating = 20 - trait.rating
          else
             return nil
          end
        end
      return trait_rating
    end


    # Determines the success level based on the raw die result.
    # Either:  0 for failure, -1 for a botch (embarrassing failure), or
    #    the number of successes.
    def self.get_success_level(roll,rating)
      if roll == rating
           result = "critical_success"
         else
            if roll == 20
              result = "critical_failure"
            else
               if roll < rating
                  result = "success"
               else
                  result = "failure"
               end
            end
        end
    end

    # Determines the result and composes the result message
    def self.get_success_title(level)
        success_title = t('pentraits.' + level)
    end    

#    def self.emit_results(message, client, room, is_private)
#    if (is_private)
#        client.emit message
#      else
#        room.emit message
        
    def self.emit_results(message, room)
      room.emit message
      if (room.scene)
         Scenes.add_to_scene(room.scene, message)
      end
      Global.logger.info "Trait check results: #{message}"
    end

    # Determines the result and composes the result message
    def self.do_trait_check_message(char,trait,enactor)
       trait_rating = PenTraits.get_trait_rating(char,trait)
       if !trait_rating
          return { error: t('pentraits.trait_not_found',
                          :name => trait) }
       end
       roll = PenTraits.roll  
       level = PenTraits.get_success_level(roll, trait_rating)
       if (level == "critical_success")
         Achievements.award_achievement(char, "critical_check")
       end
       result = PenTraits.get_success_title(level)
       if (char == enactor)
           message = t('pentraits.check_result', 
                    :name => char.name, 
                    :trait => trait, 
                    :rating => trait_rating, 
                    :roll => roll,
                    :success => result)
       else 
           message = t('pentraits.check_result_admin',
                    :name => char.name,
                    :trait => trait,
                    :rating => trait_rating,
                    :roll => roll,
                    :success => result,
                    :admin => enactor.name)
       end
       if level == "failure"
          message = message + "%r" + t('pentraits.check_opposing')
          trait_name = PenTraits.get_opp_trait(trait)
          trait_rating = PenTraits.get_trait_rating(char,trait_name)
          roll = PenTraits.roll
          level = PenTraits.get_success_level(roll, trait_rating)
          result = PenTraits.get_success_title(level)
          message = message + t('pentraits.check_result',
                    :name => char.name,
                    :trait => trait_name,
                    :rating => trait_rating,
                    :roll => roll,
                    :success => result)
          if level == "failure"
            message = message + "%r" + t('pentraits.check_both_fail')
          else
            if level == "critical_failure"
               message = message + "%r" + t('pentraits.check_critical_fail', :opposite => trait)
            end
          end
        else
          if level == "critical_failure"
             opposite = PenTraits.get_opp_trait(trait)
             message = message + "%r" + t('pentraits.check_critical_fail', :opposite => opposite)
          end 
        end
      return message
     end

    # Returns either { message: roll_result_message }  or  { error: error_message }
    def self.determine_web_check_result(request, char, enactor)
      
      pc_name = request.args[:pc_name] || ""
      pc_trait = request.args[:pc_trait] || ""
      if (pc_trait == "")    
         pc_trait = request.args[:check_string].titlecase || ""
      end
      if !PenTraits.is_valid_trait?(pc_trait)
         return { error: t('pentraits.trait_not_found', :name => pc_trait) }
      end 
      
      # ------------------
      # PC ROLL
      # ------------------
      if (!pc_name.blank?)
        if enactor.is_admin? 
           char = Character.find_one_by_name(pc_name)
           if (char)
              message = PenTraits.do_trait_check_message(char, pc_trait, enactor)
           else return { error: t('pentraits.invalid_char_name') }
           end
        else
           return { error: t('pentraits.no_admin') }
        end  
      # ------------------
      # SELF ROLL
      # ------------------
      
      else
        message = PenTraits.do_trait_check_message(enactor, pc_trait, enactor)
      end
      
      return { message: message }
    end

  end
end
