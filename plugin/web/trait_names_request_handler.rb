module AresMUSH
  module PenTraits
    class TraitNamesRequestHandler

      def handle(request)
        traits = []
        PenTraits.positives.each do |a|
           traits << a
           b = PenTraits.get_opp_trait(a)
           traits << b
        end
        pentraits = traits.sort
        return pentraits
      end

    end
  end
end
