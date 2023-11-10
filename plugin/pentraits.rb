$:.unshift File.dirname(__FILE__)

module AresMUSH
  module PenTraits
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.traits
      Global.read_config("pentraits", "traits")
    end
 
    def self.shortcuts
      Global.read_config("pentraits", "shortcuts")
    end

    def self.achievements
      Global.read_config('pentraits', 'achievements')
    end
    
    def self.get_cmd_handler(client, cmd, enactor)      
      case cmd.root
      when "trait"
        case cmd.switch
        when "opp"
          return GetOppTraitCmd
        when "raise"
          return RaiseTraitCmd
        when "lower"
          return LowerTraitCmd
        when "reset"
          return ResetTraitsCmd
        when "set"
          return SetTraitCmd
        when "points"
          return TraitPointsCmd
        else
          return ListTraitsCmd
        end
      when "check"
        return CheckTraitCmd
      else
        return nil
      end
    end

#  def self.get_event_handler(event_name) 
#      case event_name
#      when "CronEvent"
#        return CronEventHandler
#      end
#      nil
#    end
#
    def self.get_web_request_handler(request)
      case request.cmd
      when "resetTraits"
        return ResetTraitsRequestHandler      
      when "addSceneCheck"
        return AddSceneCheckRequestHandler
      when "addJobCheck"
        return AddJobCheckRequestHandler
      when "penTraits"
        return TraitNamesRequestHandler
       end
      nil
    end
    
  end
end
