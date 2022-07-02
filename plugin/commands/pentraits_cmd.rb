module AresMUSH

  module PenTraits
    class GetOppTraitCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = titlecase_arg(cmd.args)
      end

      def required_args
        [ self.name ]
      end
      
      def handle
        opposite = PenTraits.get_opp_trait(self.name)
        client.emit_success opposite
      end
    end
  end
end
