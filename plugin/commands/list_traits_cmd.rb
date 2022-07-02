module AresMUSH
  module PenTraits
    class ListTraitsCmd
      include CommandHandler

      def handle
        template = TraitsTemplate.new enactor
	client.emit template.render
      end

    end
  end
end
