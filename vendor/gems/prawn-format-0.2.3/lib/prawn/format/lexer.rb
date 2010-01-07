# encoding: utf-8

require 'strscan'

module Prawn
  module Format

    # The Lexer class is used by the formatting subsystem to scan a string
    # and extract tokens from it. The tokens it looks for are either text,
    # XML entities, or XML tags.
    #
    # Note that the lexer only scans for a subset of XML--it is not a true
    # XML scanner, and understands just enough to provide a basic markup
    # language for use in formatting documents.
    #
    # The subset includes only XML entities and tags--instructions, comments,
    # and the like are not supported.
    class Lexer
      # When the scanner encounters a state or entity it is not able to
      # handle, this exception will be raised.
      class InvalidFormat < RuntimeError; end

      # Controls whether whitespace is lexed verbatim or not. If not,
      # adjacent whitespace is compressed into a single space character
      # (this includes newlines).
      attr_accessor :verbatim

      # Create a new lexer that will scan the given text. The text must be
      # UTF-8 encoded, and must consist of well-formed XML in the subset
      # understand by the lexer.
      def initialize(text)
        @scanner = StringScanner.new(text)
        @state = :start
        @verbatim = false
      end

      # Returns the next token from the scanner. If the end of the string
      # has been reached, this will return nil. Otherwise, the token itself
      # is returned as a hash. The hash will always include a :type key,
      # identifying the type of the token. It will be one of :text, :open,
      # or :close.
      #
      # For :text tokens, the hash will also contain a :text key, which will
      # point to an array of strings. Each element of the array contains
      # either word, whitespace, or some other character at which the line
      # may be broken.
      #
      # For :open tokens, the hash will contain a :tag key which identifies
      # the name of the tag (as a symbol), and an :options key, which
      # is another hash that contains the options that were given with the
      # tag.
      #
      # For :close tokens, the hash will contain only a :tag key.
      def next
        if @state == :start && @scanner.eos?
          return nil
        else
          scan_next_token
        end
      end

      # Iterates over each token in the string, until the end of the string
      # is reached. Each token is yielded. See #next for a discussion of the
      # available token types.
      def each
        while (token = next_token)
          yield token
        end
      end

      private

        def scan_next_token
          case @state
          when :start then scan_start_state
          when :self_close then scan_self_close_state
          end
        end

        if RUBY_VERSION >= "1.9.0"
          def scan_other_text
            @scanner.scan(/[^-\xE2\x80\x94\s<&]+/)
          end
        else
          def scan_other_text
            return nil if @scanner.eos?

            result = @scanner.scan_until(/[-\s<&]|\xE2\x80\x94/)
            if result
              @scanner.pos -= @scanner.matched.length
              return nil if result == "<" || result == "&"
              return result[0,result.length - @scanner.matched.length]
            else
              result = @scanner.rest
              @scanner.terminate
              return result
            end
          end
        end

        def scan_text_chunk
          @scanner.scan(/-/)            || # hyphen
          @scanner.scan(/\xe2\x80\x94/) || # mdash
          scan_other_text
        end

        def scan_verbatim_text_chunk
          @scanner.scan(/\r\n|\r|\n/) || # newline
          @scanner.scan(/\t/)         || # tab
          @scanner.scan(/ +/)         || # spaces
          scan_text_chunk
        end

        def scan_nonverbatim_text_chunk
          (@scanner.scan(/\s+/) && " ") || # whitespace
          scan_text_chunk
        end

        def scan_next_text_chunk
          if @verbatim
            scan_verbatim_text_chunk
          else
            scan_nonverbatim_text_chunk
          end
        end

        def scan_start_state
          if @scanner.scan(/</)
            if @scanner.scan(%r(/))
              scan_end_tag
            else
              scan_open_tag
            end
          elsif @scanner.scan(/&/)
            scan_entity
          else
            pieces = []
            loop do
              chunk = scan_next_text_chunk or break
              pieces << chunk
            end
            { :type => :text, :text => pieces }
          end
        end

        ENTITY_MAP = {
          "lt"    => "<",
          "gt"    => ">",
          "amp"   => "&",
          "mdash" => "\xE2\x80\x94",
          "ndash" => "\xE2\x80\x93",
          "nbsp"  => "\xC2\xA0",
          "bull"  => "\342\200\242",
          "quot"  => '"',
        }

        def scan_entity
          entity = @scanner.scan(/(?:#x?)?\w+/) or error("bad format for entity")
          @scanner.scan(/;/) or error("missing semicolon to terminate entity")

          text = case entity
            when /#(\d+)/ then [$1.to_i].pack("U*")
            when /#x([0-9a-f]+)/ then [$1.to_i(16)].pack("U*")
            else
              result = ENTITY_MAP[entity] or error("unrecognized entity #{entity.inspect}")
              result.dup
            end

          { :type => :text, :text => [text] }
        end

        def scan_open_tag
          tag = @scanner.scan(/\w+/) or error("'<' without valid tag")
          tag = tag.downcase.to_sym

          options = {}
          @scanner.skip(/\s*/)
          while !@scanner.eos? && @scanner.peek(1) =~ /\w/
            name = @scanner.scan(/\w+/)
            @scanner.scan(/\s*=\s*/) or error("expected assigment after option #{name}")
            if (delim = @scanner.scan(/['"]/))
              value = @scanner.scan(/[^#{delim}]*/)
              @scanner.scan(/#{delim}/) or error("expected option value to end with #{delim}")
            else
              value = @scanner.scan(/[^\s>]*/)
            end
            options[name.downcase.to_sym] = value
            @scanner.skip(/\s*/)
          end

          if @scanner.scan(%r(/))
            @self_close = true
            @tag = tag
            @state = :self_close
          else
            @self_close = false
            @state = :start
          end

          @scanner.scan(/>/) or error("unclosed tag #{tag.inspect}")

          { :type => :open, :tag => tag, :options => options }
        end

        def scan_end_tag
          tag = @scanner.scan(/\w+/).to_sym
          @scanner.skip(/\s*/)
          @scanner.scan(/>/) or error("unclosed ending tag #{tag.inspect}")
          { :type => :close, :tag => tag }
        end

        def scan_self_close_state
          @state = :start
          { :type => :close, :tag => @tag }
        end

        def error(message)
          raise InvalidFormat, "#{message} at #{@scanner.pos} -> #{@scanner.rest.inspect[0,50]}..."
        end
    end
  end
end
