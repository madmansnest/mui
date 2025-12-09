# frozen_string_literal: true

module Mui
  module Syntax
    module Lexers
      # Lexer for Ruby source code
      class RubyLexer < LexerBase
        KEYWORDS = %w[
          BEGIN END __ENCODING__ __END__ __FILE__ __LINE__
          alias and begin break case class def defined? do
          else elsif end ensure false for if in module next
          nil not or redo rescue retry return self super then
          true undef unless until when while yield
          require require_relative attr_reader attr_writer attr_accessor
          private protected public include extend prepend
          raise fail catch throw
        ].freeze

        KEYWORD_PATTERN = /\b(?:#{KEYWORDS.join("|")})\b/

        protected

        def token_patterns
          @token_patterns ||= [
            # Single line comment
            [:comment, /#.*/],
            # Double quoted string (with escape handling)
            [:string, /"(?:[^"\\]|\\.)*"/],
            # Single quoted string (with escape handling)
            [:string, /'(?:[^'\\]|\\.)*'/],
            # Symbols
            [:symbol, /:[a-zA-Z_][a-zA-Z0-9_]*[?!]?/],
            # Float numbers (must be before integer)
            [:number, /\b\d+\.\d+(?:e[+-]?\d+)?\b/i],
            # Hexadecimal
            [:number, /\b0x[0-9a-f]+\b/i],
            # Octal
            [:number, /\b0o?[0-7]+\b/],
            # Binary
            [:number, /\b0b[01]+\b/i],
            # Integer
            [:number, /\b\d+\b/],
            # Constants (capitalized identifiers)
            [:constant, /\b[A-Z][a-zA-Z0-9_]*\b/],
            # Keywords
            [:keyword, KEYWORD_PATTERN],
            # Instance variables (@foo, @@foo)
            [:instance_variable, /@{1,2}[a-zA-Z_][a-zA-Z0-9_]*/],
            # Global variables
            [:global_variable, /\$[a-zA-Z_][a-zA-Z0-9_]*/],
            # Method calls (.to_i, .each, .map!, .empty?, etc.)
            [:method_call, /\.[a-z_][a-zA-Z0-9_]*[?!]?/],
            # Identifiers (including method names with ? or !)
            [:identifier, /\b[a-z_][a-zA-Z0-9_]*[?!]?/],
            # Operators
            [:operator, %r{[+\-*/%&|^~<>=!]+|<<|>>|\*\*}]
          ]
        end

        # Handle =begin...=end block comments
        def handle_multiline_state(line, pos, state)
          return [nil, nil, pos] unless state == :block_comment

          # Check for =end
          text = line[pos..]
          if line[pos..].match?(/\A=end\b/)
            token = Token.new(
              type: :comment,
              start_col: pos,
              end_col: line.length - 1,
              text:
            )
            [token, nil, line.length]
          else
            # Entire line is part of block comment
            unless text.empty?
              token = Token.new(
                type: :comment,
                start_col: pos,
                end_col: line.length - 1,
                text:
              )
            end
            [token, :block_comment, line.length]
          end
        end

        # Check for =begin block comment start
        def check_multiline_start(line, pos)
          return [nil, nil, pos] unless pos.zero?

          if line.match?(/\A=begin\b/)
            token = Token.new(
              type: :comment,
              start_col: 0,
              end_col: line.length - 1,
              text: line
            )
            [:block_comment, token, line.length]
          else
            [nil, nil, pos]
          end
        end
      end
    end
  end
end
