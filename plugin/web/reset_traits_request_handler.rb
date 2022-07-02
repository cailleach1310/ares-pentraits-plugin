module AresMUSH
  module PenTraits
    class ResetTraitsRequestHandler
      def handle(request)
         char = Character.find_one_by_name request.args[:name]
         if !char
             return { error: t('pentraits.invalid_char_name') }
         else 
             PenTraits.reset_char(char)        
         end
         {
             name: char.name 
         }
      end
    end
  end
end

