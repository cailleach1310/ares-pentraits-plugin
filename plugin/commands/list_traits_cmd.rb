module AresMUSH
  module PenTraits
    class ListTraitsCmd
      include CommandHandler

      def handle
        if PenTraits.not_set?(enactor)
           PenTraits.init_traits(enactor)
        end
        template = TraitsTemplate.new enactor
	client.emit template.render
      end

    end
  end
end
