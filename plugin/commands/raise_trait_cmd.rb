module AresMUSH

  module PenTraits
    class RaiseTraitCmd
      include CommandHandler
      
      attr_accessor :name, :trait_name, :rating
      
      def parse_args
        self.name = enactor_name
        self.trait_name = titlecase_arg(cmd.args)
      end

      def required_args
        [ self.name, self.trait_name ]
      end
      
      def check_can_raise
        return nil if enactor_name == self.name
        return nil if PenTraits.can_manage_traits?(enactor)
        return t('dispatcher.not_allowed')
      end      
      
      def check_chargen_locked
        return nil if PenTraits.can_manage_traits?(enactor)
        Chargen.check_chargen_locked(enactor)
      end
      
      def handle
        error = !PenTraits.is_valid_trait?(trait_name)
        if (error)
           client.emit_failure(t('pentraits.trait_not_found',
                          :name => trait_name))
           return
        else
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|        
          rating = PenTraits.get_trait_rating(model,self.trait_name)
          new_rating = rating + 1
          error = PenTraits.check_rating(self.trait_name, new_rating)
          if (error)
            client.emit_failure error
            return
          end
          
          error = PenTraits.set_trait(model, self.trait_name, new_rating)
          if (error)
            client.emit_failure error
          else
            client.emit_success t("pentraits.trait_raise", :target => model.name, :name => self.trait_name, :rating => new_rating)
          end
        end  
        end
      end
    end
  end
end
