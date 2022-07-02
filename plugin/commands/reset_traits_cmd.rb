module AresMUSH

  module PenTraits
    class ResetTraitsCmd
      include CommandHandler

      def check_chargen_locked
        Chargen.check_chargen_locked(enactor)
      end

      def handle
        PenTraits.reset_char(enactor)        
        client.emit_success t('pentraits.reset_complete')
      end
    end
  end
end
