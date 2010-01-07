# encoding: utf-8

require 'prawn/format/instructions/base'
require 'prawn/format/effects/link'
require 'prawn/format/effects/underline'

module Prawn
  module Format
    module Instructions

      class TagOpen < Base
        attr_reader :tag

        def initialize(state, tag)
          super(state)
          @tag = tag
        end

        def draw(document, draw_state, options={})
          draw_width(document, draw_state)
          draw_destination(document, draw_state)
          draw_link(document, draw_state)
          draw_underline(document, draw_state)
        end

        def start_verbatim?
          @tag[:style][:white_space] == :pre
        end

        def style
          @tag[:style]
        end

        def width
          @state.width
        end

        private

          def draw_width(document, draw_state)
            if width > 0
              draw_state[:dx] += width
              draw_state[:text].move_to(draw_state[:dx], draw_state[:dy])
            end
          end

          def draw_destination(document, draw_state)
            return unless tag[:style][:anchor]

            x = draw_state[:real_x]
            y = draw_state[:real_y] + draw_state[:dy] + ascent

            label, destination = case tag[:style][:anchor]
              when /^zoom=([\d\.]+):(.*)$/
                [$2, document.dest_xyz(x, y, $1.to_f)]
              when /^fit:(.*)$/
                [$1, document.dest_fit]
              when /^fith:(.*)$/
                [$1, document.dest_fit_horizontally(y)]
              when /^fitv:(.*)$/
                [$1, document.dest_fit_vertically(x)]
              when /^fitb:(.*)$/
                [$1, document.dest_fit_bounds]
              when /^fitbh:(.*)$/
                [$1, document.dest_fit_bounds_horizontally(y)]
              when /^fitbv:(.*)$/
                [$1, document.dest_fit_bounds_vertically(x)]
              else
                [tag[:style][:anchor], document.dest_fit_bounds]
              end

            document.add_dest(label, destination)
          end

          def draw_link(document, draw_state)
            return unless tag[:style][:target]
            add_effect(Effects::Link.new(tag[:style][:target], draw_state[:dx]), draw_state)
          end

          def draw_underline(document, draw_state)
            return unless tag[:style][:text_decoration] == :underline
            add_effect(Effects::Underline.new(draw_state[:dx], @state), draw_state)
          end

          def add_effect(effect, draw_state)
            tag[:effects] ||= []
            tag[:effects].push(effect)

            draw_state[:pending_effects].push(effect)
          end
      end

    end
  end
end
