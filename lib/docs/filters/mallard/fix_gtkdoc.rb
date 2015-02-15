module Docs
  class Mallard
    # Filter that fixes all internal GtkDoc links such as function(), #type,
    # etc.
    class FixGtkdocFilter < Filter
      NAMESPACES = {
        'g' => 'gobject',
        'gtk' => 'gtk'
      }

      def call
        css('p').each { |node| fix_parentheses_link node }
        doc
      end

      def fix_parentheses_link(node)
        node.inner_html = node.inner_html.gsub(/([A-Za-z_]+)\(\)/) do
          symbol = $1
          c_prefix, symbol_link = parse_c_symbol symbol
          return $& unless NAMESPACES.key? c_prefix
          namespace = NAMESPACES.fetch c_prefix
          "<a href='#{namespace}.#{symbol_link}'>#{symbol}</a>"
        end
      end

      # Returns the namespace and the rest of the symbol.
      def parse_c_symbol(symbol)
        return symbol.split('_', 2).map(&:downcase) if symbol.index '_'
        camelcase_match = symbol.match(/^[A-Z][a-z]*/)
        return ['', symbol.downcase] unless camelcase_match
        c_prefix = camelcase_match[0]
        [c_prefix, symbol[c_prefix.length..-1]].map(&:downcase)
      end
    end
  end
end
