module AresMUSH
  module Profile
    class CustomCharFields
      
      # Gets custom fields for display in a character profile.
      #
      # @param [Character] char - The character being requested.
      # @param [Character] viewer - The character viewing the profile. May be nil if someone is viewing
      #    the profile without being logged in.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Ansi or markdown text strings must be formatted for display.
      # @example
      #    return { goals: Website.format_markdown_for_html(char.goals) }
      def self.get_fields_for_viewing(char, viewer)
        return { goals: Website.format_markdown_for_html(char.goals),
          marque: char.marque.to_i,
          connections: Website.format_markdown_for_html(char.connections),
          pen_traits: PenTraits.build_web_char_data(char, viewer),
          dowayne: char.ranks_rank == "Dowayne" }
      end
    
      # Gets custom fields for the character profile editor.
      #
      # @param [Character] char - The character being requested.
      # @param [Character] viewer - The character editing the profile.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Multi-line text strings must be formatted for editing.
      # @example
      #    return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_editing(char, viewer)
       return { goals: Website.format_input_for_html(char.goals) }
       end

      # Gets custom fields for character creation (chargen).
      #
      # @param [Character] char - The character being requested.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Multi-line text strings must be formatted for editing.
      # @example
      #    return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_chargen(char)
         return { goals: Website.format_input_for_html(char.goals),
           marque: Website.format_input_for_html(char.marque),
           pen_traits: PenTraits.build_web_char_data(char, char),
           connections: Website.format_input_for_html(char.connections),
           cg_adept: char.ranks_rank == "Adept",
           cg_connections: char.fs3_advantages.find(name: "Connections").first != nil,
           cg_traits_set: !PenTraits.traits_not_set(char),
           cg_traits_max_points: Global.read_config("pentraits", "trait_points") }
      end
      
      # Saves fields from profile editing.
      #
      # @param [Character] char - The character being updated.
      # @param [Hash] char_data - A hash of character fields and values. Your custom fields
      #    will be in char_data[:custom]. Multi-line text strings should be formatted for MUSH.
      #
      # @return [Array] - A list of error messages. Return an empty array ([]) if there are no errors.
      # @example
      #        char.update(goals: Website.format_input_for_mush(char_data[:custom][:goals]))
      #        return []
      def self.save_fields_from_profile_edit(char, char_data)
         web_goals = char_data[:custom][:goals]
         if (web_goals != "") 
           char.update(goals: Website.format_input_for_mush(char_data[:custom][:goals]))
         else
           char.update(goals: nil)
         end  
      end
      
      # Saves fields from character creation (chargen).
      #
      # @param [Character] char - The character being updated.
      # @param [Hash] chargen_data - A hash of character fields and values. Your custom fields
      #    will be in chargen_data[:custom]. Multi-line text strings should be formatted for MUSH.
      #
      # @return [Array] - A list of error messages. Return an empty array ([]) if there are no errors.
      # @example
      #        char.update(goals: Website.format_input_for_mush(chargen_data[:custom][:goals]))
      #        return []
      def self.save_fields_from_chargen(char, chargen_data)
        PenTraits.save_char(char,chargen_data)

        char.update(marque: chargen_data[:custom][:marque])

        web_goals = chargen_data[:custom][:goals]
        if (web_goals != "") 
          char.update(goals: web_goals)
        else
          char.update(goals: nil)
        end  

        web_con = chargen_data[:custom][:connections]
        if (web_con != "")
          char.update(connections: web_con)
        else
          char.update(connections: nil)
        end
        return []
      end
      
    end
  end
end
