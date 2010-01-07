# encoding: utf-8

module Prawn
  module Format
    module Instructions

      class Base
        attr_reader :state, :ascent, :descent

        def initialize(state)
          @state = state
          state.document.font_size(state.font_size) do
            @height = state.font.height
            @ascent = state.font.ascender
            @descent = state.font.descender
          end
        end

        def spaces
          0
        end

        def width(*args)
          0
        end

        def height(*args)
          @height
        end

        def break?
          false
        end

        def force_break?
          false
        end

        def discardable?
          false
        end

        def start_verbatim?
          false
        end

        def end_verbatim?
          false
        end

        def style
          {}
        end

        def accumulate(list)
          list.push(self)
        end
      end

    end
  end
end
