module AresMUSH
  module Chargen  
    
    def self.custom_app_review(char)      

      msg = ""

      traits_msg = PenTraits.app_review(char)
      if (traits_msg != "") && (traits_msg != "")
         msg = msg + "%r%xh%xr* " + traits_msg + "%xn"
      end

      if ( Marque.is_adept(char) && ( !Marque.marque_value(char) || Marque.marque_value(char) == "" ) )
         marque_msg = t('custom.no_marque_set')
         msg = msg + "%r%xh%xr* #{marque_msg} %xn"
      end
            
      scion_power = (char.fs3_advantages.find(name: "Scion Power").first)
      if (scion_power) && (!char.groups["scion"] || (char.groups["scion"] == "None") || (char.groups["scion"] == "")) 
         scion_msg = t('custom.no_scion_set')
         msg = msg + "%r%xh%xr* #{scion_msg} %xn"
      end
      
      connections = (char.fs3_advantages.find(name: "Connections").first)
      if ((connections) && (!(char.connections) || (char.connections == "")))
         con_msg = t('custom.no_connections_set')
         msg = msg + "%r%xh%xr* #{con_msg} %xn"
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
