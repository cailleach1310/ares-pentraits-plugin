module AresMUSH
  module PenTraits

    def self.reset_char(char)
      PenTraits.positives.each do |a|
        PenTraits.set_trait(char, a, 10)
      end
    end

    def self.set_trait(char, trait_name, rating)
      error = !PenTraits.is_valid_trait?(trait_name)
      if (error)
         client.emit_failure(t('pentraits.trait_not_found', :name => trait_name))
         return
      end   
      trait_name = trait_name.titleize
      if (PenTraits.positives.include?(trait_name))
        tr_storage = trait_name
        tr_rating = rating
        tr_opposite = PenTraits.get_opp_trait(trait_name)
        tr_opp_rating = 20 - rating
      else
        tr_storage = PenTraits.get_opp_trait(trait_name)
        tr_rating = 20 - rating
        tr_opposite = trait_name
        tr_opp_rating = rating
      end

      trait = PenTraits.find_trait(char, tr_storage)
      
      if (trait)
        trait.update(rating: tr_rating, opp_rating: tr_opp_rating)
          
      else
        trait = PendragonTraits.create(character: char, name: tr_storage, rating: tr_rating, opposite: tr_opposite, opp_rating: tr_opp_rating)
      end
       
      return nil
    end

    def self.can_manage_traits?(actor)
      actor && actor.has_permission?("manage_abilities")
    end

    def self.check_rating(trait_name, rating)
      min_rating = PenTraits.get_min_rating
      max_rating = PenTraits.get_max_rating

      return t('pentraits.max_rating_is', :rating => max_rating) if (rating > max_rating)
      return t('pentraits.min_rating_is', :rating => min_rating) if (rating < min_rating)
      return nil
    end

    def self.get_min_rating()
      min_rating = Global.read_config("pentraits", "min_rating")
    end

    def self.get_max_rating()
      max_rating = Global.read_config("pentraits", "max_rating")
    end

    def self.char_update(char,traits)
      traits.each do |element|
        name = element.name
        rating = element.rating 
        self.set_trait(char,name,rating)
      end   
    end

  end
end
