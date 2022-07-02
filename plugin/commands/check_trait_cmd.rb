module AresMUSH

  module PenTraits
    class CheckTraitCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = titlecase_arg(cmd.args)
      end

      def required_args
        [ self.name ]
      end
      
      def handle
        error = !PenTraits.is_valid_trait?(name)
        if (error)
           client.emit_failure(t('pentraits.trait_not_found',
                          :name => name))
           return
        else
           message = PenTraits.do_trait_check_message(enactor,self.name,enactor)
           Achievements.award_achievement(enactor, "trait_check")
           PenTraits.emit_results(message, enactor_room)
        end
      end

    end
  end
end
