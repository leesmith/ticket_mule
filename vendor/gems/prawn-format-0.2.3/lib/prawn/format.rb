# encoding: utf-8

require 'prawn/format/layout_builder'
require 'prawn/format/text_object'

module Prawn
  module Format

    # Overloaded version of #text.
    def text(text, options={}) #:nodoc:
      if unformatted?(text, options)
        super
      else
        format(text, options)
      end
    end

    # Overloaded version of #height_of.
    def height_of(string, line_width, size=font_size, options={}) #:nodoc:
      if unformatted?(string, options)
        super(string, line_width, size)
      else
        formatted_height(string, line_width, size, options)
      end
    end

    # Overloaded version of #width_of.
    def width_of(string, options={}) #:nodoc:
      if unformatted?(string, options)
        super
      else
        formatted_width(string, options)
      end
    end

    DEFAULT_TAGS = {
      :a      => { :meta => { :name => :anchor, :href => :target }, :color => "0000ff", :text_decoration => :underline },
      :b      => { :font_weight => :bold },
      :br     => { :display => :break },
      :code   => { :font_family => "Courier", :font_size => "90%" },
      :em     => { :font_style => :italic },
      :font   => { :meta => { :face => :font_family, :color => :color, :size => :font_size } },
      :i      => { :font_style => :italic },
      :pre    => { :white_space => :pre, :font_family => "Courier", :font_size => "90%" },
      :span   => {},
      :strong => { :font_weight => :bold },
      :sub    => { :vertical_align => :sub, :font_size => "70%" },
      :sup    => { :vertical_align => :super, :font_size => "70%" },
      :tt     => { :font_family => "Courier" },
      :u      => { :text_decoration => :underline },
    }.freeze

    def tags(update={})
      @tags ||= DEFAULT_TAGS.dup
      @tags.update(update)
    end

    def styles(update={})
      @styles ||= {}
      @styles.update(update)
    end

    def default_style
      { :font_family => font.family || font.name,
        :font_size   => font_size,
        :color       => fill_color }
    end

    def evaluate_measure(measure, options={})
      case measure
      when nil then nil
      when Numeric then return measure
      when Symbol then
        mappings = options[:mappings] || {}
        raise ArgumentError, "unrecognized value #{measure.inspect}" unless mappings.key?(measure)
        return evaluate_measure(mappings[measure], options)
      when String then
        operator, value, unit = measure.match(/^([-+]?)(\d+(?:\.\d+)?)(.*)$/)[1,3]

        value = case unit
          when "%" then
            relative = options[:relative] || 0
            relative * value.to_f / 100
          when "em" then
            # not a true em, but good enough for approximating. patches welcome.
            value.to_f * (options[:em] || font_size)
          when "", "pt" then return value.to_f
          when "pc" then return value.to_f * 12
          when "in" then return value.to_f * 72
          else raise ArgumentError, "unsupport units in style value: #{measure.inspect}"
          end

        current = options[:current] || 0
        case operator
        when "+" then return current + value
        when "-" then return current - value
        else return value
        end
      else return measure.to_f
      end
    end

    def draw_lines(x, y, width, lines, options={})
      real_x, real_y = translate(x, y)

      state = options[:state] || {}
      options[:align] ||= :left

      state = state.merge(:width => width,
        :x => x, :y => y,
        :real_x => real_x, :real_y => real_y,
        :dx => 0, :dy => 0)

      state[:cookies] ||= {}
      state[:pending_effects] ||= []

      return state if lines.empty?

      text_object do |text|
        text.rotate(real_x, real_y, options[:rotate] || 0)
        state[:text] = text
        lines.each { |line| line.draw_on(self, state, options) }
      end

      state.delete(:text)

      #rectangle [x, y+state[:dy]], width, state[:dy]
      #stroke

      return state
    end

    def layout(text, options={})
      helper = Format::LayoutBuilder.new(self, text, options)
      yield helper if block_given?
      return helper
    end

    def format(text, options={})
      if options[:at]
        x, y = options[:at]
        format_positioned_text(text, x, y, options)
      else
        format_wrapped_text(text, options)
      end
    end

    def text_object
      object = TextObject.new

      if block_given?
        yield object.open
        add_content(object.close)
      end

      return object
    end

    private

      def unformatted?(text, options={})
        # If they have a preference, use it
        if options.key?(:plain)
          return options[:plain]

        # Otherwise, if they're asking for full-justification, we must assume
        # the text is formatted (since Prawn's text() method has no full justification)
        elsif options[:align] == :justify
          return false

        # Otherwise, look for tags or XML entities in the text
        else
          return text !~ /<|&(?:#x?)?\w+;/
        end
      end

      def format_positioned_text(text, x, y, options={})
        helper = layout(text, options)
        line = helper.next
        draw_lines(x, y+line.ascent, line.width, [line], options)
      end

      def format_wrapped_text(text, options={})
        helper = layout(text, options)

        start_new_page if self.y < bounds.absolute_bottom

        until helper.done?
          y = self.y - bounds.absolute_bottom
          height = bounds.stretchy? ? bounds.absolute_top : y

          y = helper.fill(bounds.left, y, bounds.width, options.merge(:height => height))

          if helper.done?
            self.y = y + bounds.absolute_bottom
          else
            start_new_page
          end
        end
      end

      def formatted_height(string, line_width, size=font_size, options={})
        helper = layout(string, options.merge(:size => size))
        lines = helper.word_wrap(line_width)
        return lines.inject(0) { |s, line| s + line.height }
      end

      def formatted_width(string, options={})
        helper = layout(string, options)
        helper.next.width
      end
  end
end

Prawn::Document.extensions << Prawn::Format
