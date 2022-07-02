module AresMUSH
  module Chargen  
    
    def self.custom_app_review(char)      

      msg = ""

      traits_msg = PenTraits.app_review(char)
      if (traits_msg != "") && (traits_msg != "")
         msg = msg + "%r%xh%xr* " + traits_msg + "%xn"
      end
 
      if (msg == "")
         msg = t('chargen.ok')
      else
         msg = "%xh%xr< See issues below >%xn%r" + msg
      end

      return Chargen.format_review_status "Checking custom settings.", msg
      #
      # You can also use other built-in chargen status messages, like t('chargen.not_set').  
      # See https://www.aresmush.com/tutorials/config/chargen.html for details.
    end
  end
end
