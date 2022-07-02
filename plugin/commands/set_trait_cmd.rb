module AresMUSH

  module PenTraits
    class SetTraitCmd
      include CommandHandler
      
      attr_accessor :name, :trait_name, :rating
      
      def parse_args
        if (cmd.args =~ /[^\/]+\=.+\/.+/)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
          self.name = trim_arg(args.arg1)
          self.trait_name = titlecase_arg(args.arg2)
          self.rating = trim_arg(args.arg3)
        else
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.name = enactor_name
          self.trait_name = titlecase_arg(args.arg1)
          self.rating = trim_arg(args.arg2)
        end
      end

      def required_args
        [ self.name, self.trait_name, self.rating ]
      end
      
      def check_valid_rating
        return nil if !self.rating
        return t('pentraits.invalid_rating') if !self.rating.is_integer?
        return nil
      end
      
      def check_can_set
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
          new_rating = self.rating.to_i
          error = PenTraits.check_rating(self.trait_name, new_rating)
          if (error)
            client.emit_failure error
            return
          end
          
          error = PenTraits.set_trait(model, self.trait_name, new_rating)
          if (error)
            client.emit_failure error
          else
            client.emit_success t("pentraits.trait_set", :target => model.name, :name => self.trait_name, :rating => new_rating)
          end
         end 
        end
      end
    end
  end
end
