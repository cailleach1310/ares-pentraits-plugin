module AresMUSH

  module PenTraits
    class TraitPointsCmd
      include CommandHandler

      def check_chargen_locked
        Chargen.check_chargen_locked(enactor)
      end

      def handle
        points = PenTraits.count_trait_points(enactor)        
        client.emit "You have spent #{points} points on traits."
      end
    end
  end
end
