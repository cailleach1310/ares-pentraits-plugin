module AresMUSH
  module PenTraits
    class PenTraitsForCheckRequestHandler

      def handle(request)
        traits = []
        PenTraits.positives.each do |a|
           traits << a
           b = PenTraits.get_opp_trait(a)
           traits << b
        end
        traits.sort
      end

    end
  end
end
