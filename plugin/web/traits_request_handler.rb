module AresMUSH
  module PenTraits
    class TraitsRequestHandler
      def handle(request)
        traits = PenTraits.traits.sort_by { |a| a['name'] }.map { |a| { name: a['name'], opposite: a['opposite'] } }
        {
          traits_blurb:  Website.format_markdown_for_html(PenTraits.traits_blurb),          
          
          traits: traits
        } 
      end
    end
  end
end

