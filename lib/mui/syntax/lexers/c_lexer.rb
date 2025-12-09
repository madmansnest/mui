# frozen_string_literal: true

module Mui
  module Syntax
    module Lexers
      # Lexer for C source code
      class CLexer < LexerBase
        # Type keywords (data types)
        TYPES = %w[
          char double float int long short signed unsigned void
          _Bool _Complex _Imaginary
        ].freeze

        # Storage class and other keywords
        KEYWORDS = %w[
          auto break case const continue default do
          else enum extern for goto if register
          return sizeof static struct switch typedef
          union volatile while
          inline restrict
          _Alignas _Alignof _Atomic _Generic _Noreturn _Static_assert _Thread_local
        ].freeze

        TYPE_PATTERN = /\b(?:#{TYPES.join("|")})\b/
        KEYWORD_PATTERN = /\b(?:#{KEYWORDS.join("|")})\b/

        protected

        def token_patterns
          @token_patterns ||= [
            # Single line comment
            [:comment, %r{//.*}],
            # Single-line block comment /* ... */ on one line
            [:comment, %r{/\*.*?\*/}],
            # Double quoted string (with escape handling)
            [:string, /"(?:[^"\\]|\\.)*"/],
            # Character literal
            [:char, /'(?:[^'\\]|\\.)*'/],
            # Preprocessor directives
            [:preprocessor, /^\s*#\s*(?:include|define|undef|ifdef|ifndef|if|else|elif|endif|error|pragma|line)\b.*/],
            # Float numbers (must be before integer)
            [:number, /\b\d+\.\d+(?:e[+-]?\d+)?[fFlL]?\b/i],
            # Hexadecimal
            [:number, /\b0x[0-9a-fA-F]+[uUlL]*\b/],
            # Octal
            [:number, /\b0[0-7]+[uUlL]*\b/],
            # Integer
            [:number, /\b\d+[uUlL]*\b/],
            # Type keywords (int, char, void, etc.)
            [:type, TYPE_PATTERN],
            # Other keywords (if, for, return, const, static, etc.)
            [:keyword, KEYWORD_PATTERN],
            # Identifiers
            [:identifier, /\b[a-zA-Z_][a-zA-Z0-9_]*\b/],
            # Operators
            [:operator, %r{[+\-*/%&|^~<>=!]+|->|<<|>>|\+\+|--}]
          ]
        end

        # Handle /* ... */ block comments that span multiple lines
        def handle_multiline_state(line, pos, state)
          return [nil, nil, pos] unless state == :block_comment

          # Look for */
          end_match = line[pos..].match(%r{\*/})
          if end_match
            end_pos = pos + end_match.begin(0) + 1
            text = line[pos..end_pos]
            token = Token.new(
              type: :comment,
              start_col: pos,
              end_col: end_pos,
              text:
            )
            [token, nil, end_pos + 1]
          else
            # Entire line is part of block comment
            text = line[pos..]
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

        # Check for /* block comment start (that doesn't end on the same line)
        def check_multiline_start(line, pos)
          rest = line[pos..]

          # Check for /* that doesn't have a matching */ on this line
          start_match = rest.match(%r{/\*})
          return [nil, nil, pos] unless start_match

          start_pos = pos + start_match.begin(0)
          after_start = line[(start_pos + 2)..]

          # Check if there's a closing */ on the same line after this /*
          if after_start&.include?("*/")
            # There's a closing on this line, let normal token matching handle it
            [nil, nil, pos]
          else
            # No closing on this line, enter block comment state
            text = line[start_pos..]
            token = Token.new(
              type: :comment,
              start_col: start_pos,
              end_col: line.length - 1,
              text:
            )
            [:block_comment, token, line.length]
          end
        end

        private

        def match_token(line, pos)
          # First check for start of multiline comment
          if line[pos..].match?(%r{\A/\*})
            rest = line[(pos + 2)..]
            unless rest&.include?("*/")
              # This will be handled by check_multiline_start
              return nil
            end
          end

          super
        end
      end
    end
  end
end
