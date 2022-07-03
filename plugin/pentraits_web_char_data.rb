module AresMUSH
  module PenTraits
    class WebTraitsDataBuilder
      def build(char, viewer)
        is_owner = (viewer && viewer.id == char.id)
        
        show_traits = PenTraits.can_manage_traits?(viewer) || is_owner
        
        if show_traits
           return get_trait_list(char.pen_traits)
        else
           return nil
        end
      end

      def get_trait_list(list)
        list.to_a.sort_by { |a| a.name }.map { |a|
          {
            name: a.name,
            rating: a.rating,
            opposite: a.opposite,
            opp_rating: a.opp_rating
          }}
      end

    end
  end
end
