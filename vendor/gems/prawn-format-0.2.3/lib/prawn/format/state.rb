# encoding: utf-8

module Prawn
  module Format
    class State
      attr_reader :document
      attr_reader :original_style, :style

      def initialize(document, options={})
        @document = document
        @previous = options[:previous]

        @original_style = (@previous && @previous.inheritable_style || {}).
          merge(options[:style] || {})

        compute_styles!

        @style[:kerning] = font.has_kerning_data? unless @style.key?(:kerning)
      end

      def inheritable_style
        @inheritable_style ||= begin
          subset = original_style.dup
          subset.delete(:meta)
          subset.delete(:display)
          subset.delete(:width)

          # explicitly set font-size so that relative font-sizes don't get
          # recomputed upon each nesting.
          subset[:font_size] = font_size

          subset
        end
      end

      def kerning?
        @style[:kerning]
      end

      def display
        @style[:display] || :inline
      end

      def font_size
        @style[:font_size] || 12
      end

      def font_family
        @style[:font_family] || "Helvetica"
      end

      def font_style
        @style[:font_style] || :normal
      end

      def font_weight
        @style[:font_weight] || :normal
      end

      def color
        @style[:color] || "000000"
      end

      def vertical_align
        @style[:vertical_align] || 0
      end

      def text_decoration
        @style[:text_decoration] || :none
      end

      def white_space
        @style[:white_space] || :normal
      end

      def width
        @style[:width] || 0
      end

      def font
        @font ||= document.find_font(font_family, :style => pdf_font_style)
      end

      def pdf_font_style
        if bold? && italic?
          :bold_italic
        elsif bold?
          :bold
        elsif italic?
          :italic
        else
          :normal
        end
      end

      def with_style(style)
        self.class.new(document, :previous => self, :style => style)
      end

      def apply!(text_object, cookies)
        if cookies[:color] != color
          cookies[:color] = color
          text_object.fill_color(color)
        end

        if cookies[:vertical_align] != vertical_align
          cookies[:vertical_align] = vertical_align
          text_object.rise(vertical_align)
        end
      end

      def apply_font!(text_object, cookies, subset)
        if cookies[:font] != [font_family, pdf_font_style, font_size, subset]
          cookies[:font] = [font_family, pdf_font_style, font_size, subset]
          font = document.font(font_family, :style => pdf_font_style)
          font.add_to_current_page(subset)
          text_object.font(font.identifier_for(subset), font_size)
        end
      end

      def italic?
        font_style == :italic
      end

      def bold?
        font_weight == :bold
      end

      def previous(attr=nil, default=nil)
        return @previous unless attr
        return default unless @previous
        return @previous.send(attr) || default
      end

      private

        def compute_styles!
          @style = @original_style.dup

          evaluate_style(:font_size, 12, :current)
          evaluate_style(:vertical_align, 0, font_size, :super => "+40%", :sub => "-30%")
          evaluate_style(:width, 0, document.bounds.width)

          @style[:color] = evaluate_color(@style[:color])
        end

        def evaluate_style(which, default, relative_to, mappings={})
          current = previous(which, default)
          relative_to = current if relative_to == :current
          @style[which] = document.evaluate_measure(@style[which],
            :em => @previous && @previous.font_size || 12,
            :current => current, :relative => relative_to, :mappings => mappings) || default
        end

        HTML_COLORS = {
          "aqua"    => "00FFFF",
          "black"   => "000000",
          "blue"    => "0000FF",
          "fuchsia" => "FF00FF",
          "gray"    => "808080",
          "green"   => "008000",
          "lime"    => "00FF00",
          "maroon"  => "800000",
          "navy"    => "000080",
          "olive"   => "808000",
          "purple"  => "800080",
          "red"     => "FF0000",
          "silver"  => "C0C0C0",
          "teal"    => "008080",
          "white"   => "FFFFFF",
          "yellow"  => "FFFF00"
        }

        def evaluate_color(color)
          case color
          when nil then nil
          when /^\s*#?([a-f0-9]{3})\s*$/i then
            return $1.gsub(/./, '\&0')
          when /^\s*#?([a-f0-9]+)$\s*/i then
            return $1
          when /^\s*rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)\s*$/
            return "%02x%02x%02x" % [$1.to_i, $2.to_i, $3.to_i]
          else
            return HTML_COLORS[color.strip.downcase]
          end
        end
    end
  end
end
