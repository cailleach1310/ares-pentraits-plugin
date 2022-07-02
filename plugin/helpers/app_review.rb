module AresMUSH
  module PenTraits

    def self.traits_not_set(char)
      PenTraits.positives.each do |p|
        if !PenTraits.find_trait(char, p)
           return t('pentraits.traits_not_set')
        end
      end
      return nil
    end

    def self.trait_point_review(char)
      points = self.count_trait_points(char)
      max = Global.read_config("pentraits", "trait_points")
      if points > max
         return t('pentraits.trait_points_spent', :total => points, :max => max)
      else
         return ""
      end
    end

    def self.trait_min_max_review(char)
      trait_min = Global.read_config("pentraits", "min_rating")
      trait_max = Global.read_config("pentraits", "max_rating")
      char.pen_traits.each do |trait|
        if (trait.rating > trait_max) || (trait.rating < trait_min)
          return t('pentraits.trait_beyond_limits', :min => trait_min, :max => trait_max)
        end
      end
     return ""
   end

  end
end
