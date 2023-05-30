module AresMUSH
  module Scenes
    
    def self.custom_scene_data(viewer)
      # Return nil if you don't need any custom data.
      return { pentraits: PenTraits.web_traitnames }
    end

  end
end
