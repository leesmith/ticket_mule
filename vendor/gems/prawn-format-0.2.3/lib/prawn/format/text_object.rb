# encoding: utf-8

require 'prawn/graphics/color'

module Prawn
  module Format
    class TextObject
      include Prawn::Graphics::Color

      RENDER_MODES = {
        :fill             => 0,
        :stroke           => 1,
        :fill_stroke      => 2,
        :invisible        => 3,
        :fill_clip        => 4,
        :stroke_clip      => 5,
        :fill_stroke_clip => 6,
        :clip             => 7
      }

      def initialize
        @content = nil
        @last_x = @last_y = 0
      end

      def open
        @content = "BT\n"
        self
      end

      def close
        @content << "ET"
        self
      end

      def move_to(x, y)
        move_by(x - @last_x, y - @last_y)
      end

      def move_by(dx,dy)
        @last_x += dx
        @last_y += dy
        @content << "#{dx} #{dy} Td\n"
        self
      end

      def next_line(dy)
      end

      def show(argument)
        instruction = argument.is_a?(Array) ? "TJ" : "Tj"
        @content << "#{Prawn::PdfObject(argument, true)} #{instruction}\n"
        self
      end

      def character_space(dc)
        @content << "#{dc} Tc\n"
        self
      end

      def word_space(dw)
        @content << "#{dw} Tw\n"
        self
      end

      def leading(dl)
        @content << "#{dl} TL\n"
        self
      end

      def font(identifier, size)
        @content << "/#{identifier} #{size} Tf\n"
        self
      end

      def render(mode)
        mode_value = RENDER_MODES[mode] || raise(ArgumentError, "unsupported render mode #{mode.inspect}, should be one of #{RENDER_MODES.keys.inspect}")
        @content << "#{mode_value} Tr\n"
        self
      end

      def rise(value)
        @content << "#{value} Ts\n"
        self
      end

      def rotate(x, y, theta)
        radians = theta * Math::PI / 180
        cos, sin = Math.cos(radians), Math.sin(radians)
        arr = [cos, sin, -sin, cos, x, y]
        add_content "%.3f %.3f %.3f %.3f %.3f %.3f Tm" % arr
      end

      def to_s
        @content
      end

      def to_str
        @content
      end

      def add_content(string)
        @content << string << "\n"
      end
    end
  end
end
