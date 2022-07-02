module AresMUSH
  module PenTraits
    class TraitsTemplate < ErbTemplateRenderer
      
      attr_accessor :char
      
      def initialize(char)
        @char = char
        super File.dirname(__FILE__) + "/traits.erb"
      end
      
      def traits
        list = []
        @char.pen_traits.sort_by(:name, :order => "ALPHA").each_with_index do |l, i|
          list << format_trait(l, i)
        end
        list
      end

      def format_trait(s, i)
        trait_name = s.name.titlecase
        name = "%xh#{trait_name}:%xn"
        opposite_trait = PenTraits.get_opp_trait(trait_name)
        opposite = "%xh#{opposite_trait}:%xn"
        rating_dots = s.rating
        pos_bar = Array.new(rating_dots, "+").join
        neg_bar = Array.new(s.opp_rating, "-").join
#        neg_bar = Array.new(20 - rating_dots, "-").join
        "%r#{right(name + " " + rating_dots.to_s, 25)}   <%x37#{pos_bar}%x160#{neg_bar}%xn>   #{left(opposite + " " + (20 - rating_dots).to_s,20)}"
      end

    end
  end
end
