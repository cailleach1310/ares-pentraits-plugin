module AresMUSH
  module PenTraits

    def self.app_review(char)
       message = ""
       if !PenTraits.traits_not_set(char)
          msg = PenTraits.trait_min_max_review(char)
          msg2 = PenTraits.trait_point_review(char)
          if (msg != "") && (msg2 != "")
             fill = "%r* "
          else
             fill = ""
          end
          message = msg + fill + msg2
       else
          message = PenTraits.traits_not_set(char)
       end
    end

    def self.is_valid_trait?(name)
       if PenTraits.positives.include?(name.titlecase)
          return true
       else
          trait = PenTraits.get_opp_trait(name)
          return PenTraits.positives.include?(trait)
       end
    end

    def self.build_web_char_data(char, viewer)
      builder = WebTraitsDataBuilder.new
      builder.build(char, viewer)
    end

    def self.save_char(char, chargen_data)
      alerts = []
      (chargen_data[:custom][:pen_traits] || {}).each do |k, v, o, p|
        error = PenTraits.set_trait(char, k, v.to_i)
        if (error)
          alerts << t('pentraits.error_saving_trait', :name => k, :error => error)
        end
      end
     return alerts
    end

  end
end
