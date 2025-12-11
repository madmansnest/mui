# frozen_string_literal: true

module Mui
  # Collects words from buffer for completion
  class BufferWordCompleter
    # Minimum word length to include in completion
    MIN_WORD_LENGTH = 2
    # Maximum candidates to collect (for performance)
    MAX_CANDIDATES = 50

    def initialize(buffer)
      @buffer = buffer
    end

    # Get completion candidates matching the prefix
    # Optimized to filter while collecting, stopping early when enough candidates found
    def complete(prefix, cursor_row, cursor_col)
      return [] if prefix.empty?

      candidates = Set.new
      prefix_downcase = prefix.downcase

      @buffer.lines.each_with_index do |line, row|
        extract_matching_words(line, row, cursor_row, cursor_col, prefix, prefix_downcase, candidates)
        break if candidates.size >= MAX_CANDIDATES
      end

      candidates.to_a.sort
    end

    # Get the word prefix at cursor position
    def prefix_at(row, col)
      line = @buffer.line(row)
      return "" if col.zero? || line.empty?

      # Find word start
      start_col = col
      start_col -= 1 while start_col.positive? && word_char?(line[start_col - 1])

      line[start_col...col] || ""
    end

    private

    def extract_matching_words(line, row, exclude_row, exclude_col, prefix, prefix_downcase, candidates)
      current_word = +""
      word_start = 0

      line.each_char.with_index do |char, col|
        if word_char?(char)
          current_word << char
        else
          check_and_add_word(current_word, word_start, row, col, exclude_row, exclude_col, prefix, prefix_downcase, candidates)
          current_word = +""
          word_start = col + 1
        end
      end

      # Handle word at end of line
      check_and_add_word(current_word, word_start, row, line.length, exclude_row, exclude_col, prefix, prefix_downcase, candidates)
    end

    def check_and_add_word(word, word_start, row, col, exclude_row, exclude_col, prefix, prefix_downcase, candidates)
      return if word.length < MIN_WORD_LENGTH
      return if word == prefix
      return unless word.downcase.start_with?(prefix_downcase)

      # Don't include the word at cursor position
      at_cursor = row == exclude_row && word_start <= exclude_col && col > exclude_col
      candidates << word unless at_cursor
    end

    def word_char?(char)
      char&.match?(/\w/)
    end
  end
end
