module AresMUSH
  class Character

    collection :pen_traits, "AresMUSH::PendragonTraits"

    before_delete :delete_traits
    
    def delete_traits
      self.pen_traits.each do |list|
        list.each do |a|
          a.delete
        end
      end
    end

  end
end
