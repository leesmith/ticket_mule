# encoding: utf-8

require 'prawn/format/line'
require 'prawn/format/parser'

module Prawn
  module Format
    class LayoutBuilder
      attr_reader :document, :options

      def initialize(document, text, options={})
        @document = document
        @options  = options
        @tags     = document.tags.merge(options[:tags] || {})
        @styles   = document.styles.merge(options[:styles] || {})
        style     = document.default_style.merge(options[:default_style] || {})

        translate_prawn_options(style, options)

        @parser   = Parser.new(@document, text,
                      :tags => @tags, :styles => @styles, :style => style)

        @state    = {}
      end

      def done?
        @parser.eos?
      end

      def word_wrap(width, options={}, &block)
        if options[:height] && block
          raise ArgumentError, "cannot specify both height and a block"
        elsif options[:height]
          block = Proc.new { |l, h| h > options[:height] }
        elsif block.nil?
          block = Proc.new { |l, h| false }
        end

        lines = []
        total_height = 0

        while (line = self.next(width))
          if block[line, total_height + line.height]
            unget(line)
            break
          end

          total_height += line.height
          lines.push(line)
        end

        return lines
      end

      def fill(x, y, width, fill_options={}, &block)
        lines = word_wrap(width, fill_options, &block)
        draw_options = options.merge(fill_options).merge(:state => @state)
        @state = document.draw_lines(x, y, width, lines, draw_options)
        @state.delete(:cookies)
        return @state[:dy] + y
      end

      def next(line_width=nil)
        line = []
        width = 0
        break_at = nil

        while (instruction = @parser.next)
          next if !@parser.verbatim? && line.empty? && instruction.discardable? # ignore discardables at line start
          line.push(instruction)

          if instruction.break?
            width += instruction.width(:nondiscardable)
            break_at = line.length if line_width && width <= line_width
            width += instruction.width(:discardable)
          else
            width += instruction.width
          end

          if instruction.force_break? || line_width && width >= line_width
            break_at ||= line.length

            @parser.push(line.pop) while line.length > break_at
            hard_break = instruction.force_break? || @parser.eos?

            return Line.new(line, hard_break)
          end
        end

        Line.new(line, true) if line.any?
      end

      def unget(line)
        line.source.reverse_each { |instruction| @parser.push(instruction) }
      end

      def translate_prawn_options(style, options)
        style[:kerning] = options[:kerning] if options.key?(:kerning)
        style[:font_size] = options[:size] if options.key?(:size)

        case options[:style]
        when :bold then
          style[:font_weight] = :bold
        when :italic then
          style[:font_style] = :italic
        when :bold_italic then
          style[:font_weight] = :bold
          style[:font_style] = :italic
        end
      end
    end
  end
end
