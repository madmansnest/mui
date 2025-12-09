# frozen_string_literal: true

module Mui
  module Syntax
    # Represents a token identified by a lexer
    # Tokens are immutable value objects
    class Token
      attr_reader :type, :start_col, :end_col, :text

      # Token types:
      # :keyword     - language keywords (def, class, if, etc.)
      # :string      - string literals ("...", '...')
      # :comment     - comments (#..., //..., /* ... */)
      # :number      - numeric literals (123, 1.5, 0xFF)
      # :symbol      - Ruby symbols (:symbol)
      # :constant    - constants (ClassName, CONST)
      # :operator    - operators (+, -, =, etc.)
      # :identifier  - variable names, method names
      # :preprocessor - C preprocessor directives (#include, #define)
      # :char        - character literals ('a')
      def initialize(type:, start_col:, end_col:, text:)
        @type = type
        @start_col = start_col
        @end_col = end_col
        @text = text
      end

      def ==(other)
        return false unless other.is_a?(Token)

        type == other.type &&
          start_col == other.start_col &&
          end_col == other.end_col &&
          text == other.text
      end

      def length
        text.length
      end
    end
  end
end
