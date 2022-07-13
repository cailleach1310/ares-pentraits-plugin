module AresMUSH
  module PenTraits

    def self.find_trait(char, trait_name)
     if !trait_name
        return
     else
      trait_name = trait_name.titlecase
      char.pen_traits.find(name: trait_name).first
     end
    end

    def self.get_opp_trait(trait)
      entry = self.traits.select { |m| m['name'].upcase == trait.upcase }.first
      if (entry == nil)
        entry = self.traits.select { |m| m['opposite'].upcase == trait.upcase }.first
        entry ? entry['name'] : nil
      else
        entry['opposite'] 
     end
    end

    def self.positives
      traits = self.traits
      positives = []
      traits.each do |c|
       positives.push c['name']
      end
      positives.sort
    end

    def self.count_trait_points(char)
      points = 0
      char.pen_traits.each do |p|
         points = points + (10 - p.rating).abs
      end
      return points 
    end

  end
end
