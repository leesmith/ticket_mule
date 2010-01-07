# encoding: utf-8

require 'prawn/format/instructions/base'

module Prawn
  module Format
    module Instructions

      class Text < Base
        attr_reader :text

        def initialize(state, text, options={})
          super(state)
          @text = text
          @break = options.key?(:break) ? options[:break] : text.index(/[-\xE2\x80\x94\s]/)
          @discardable = options.key?(:discardable) ? options[:discardable] : text.index(/\s/)
          @text = state.font.normalize_encoding(@text) if options.fetch(:normalize, true)
        end

        def dup
          self.class.new(state, @text.dup, :normalize => false,
            :break => @break, :discardable => @discardable)
        end

        def accumulate(list)
          if list.last.is_a?(Text) && list.last.state == state
            list.last.text << @text
          else
            list.push(dup)
          end

          return list
        end

        def spaces
          @spaces ||= @text.scan(/ /).length
        end

        def height(ignore_discardable=false)
          if ignore_discardable && discardable?
            0
          else
            @height
          end
        end

        def break?
          @break
        end

        def discardable?
          @discardable
        end

        def compatible?(with)
          with.is_a?(self.class) && with.state == state
        end

        def width(type=:all)
          @width ||= @state.font.compute_width_of(@text, :size => @state.font_size, :kerning => @state.kerning?)

          case type
          when :discardable then discardable? ? @width : 0
          when :nondiscardable then discardable? ? 0 : @width
          else @width
          end
        end

        def to_s
          @text
        end

        def draw(document, draw_state, options={})
          @state.apply!(draw_state[:text], draw_state[:cookies])

          encoded_text = @state.font.encode_text(@text, :kerning => @state.kerning?)
          encoded_text.each do |subset, chunk|
            @state.apply_font!(draw_state[:text], draw_state[:cookies], subset)
            draw_state[:text].show(chunk)
          end
          draw_state[:dx] += width

          draw_state[:dx] += draw_state[:padding] * spaces if draw_state[:padding]
        end
      end

    end
  end
end
