module AresMUSH
  module PenTraits
    class WebTraitsDataBuilder
      def build(char, viewer)
        is_owner = (viewer && viewer.id == char.id)

        visible = Global.read_config("pentraits","trait_visibility")

        show_traits = visible || PenTraits.can_manage_traits?(viewer) || is_owner
        
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

#      def get_simple_trait_list()
#        simple_traits = []
#        PenTraits.positives.each do |a|
#           simple_traits << a
#           b = PenTraits.get_opp_trait(a)
#           simple_traits << b
#        end
#        simple_traits.sort
#      end
#
    end
  end
end
