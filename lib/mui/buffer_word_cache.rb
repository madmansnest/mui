# frozen_string_literal: true

module Mui
  # Caches words from buffer for fast completion
  # Built once when entering Insert mode, updated incrementally on changes
  class BufferWordCache
    # Minimum word length to include in cache
    MIN_WORD_LENGTH = 2
    # Maximum candidates to return (for performance)
    MAX_CANDIDATES = 50

    def initialize(buffer)
      @buffer = buffer
      @words = Set.new
      @dirty_rows = Set.new
      build_cache
    end

    # Get completion candidates matching the prefix
    def complete(prefix, cursor_row, cursor_col)
      return [] if prefix.empty?

      # Process any dirty rows first
      process_dirty_rows(cursor_row, cursor_col)

      # Get word at cursor to exclude it
      word_at_cursor = word_at_position(cursor_row, cursor_col)

      prefix_downcase = prefix.downcase
      candidates = @words.select do |w|
        w != prefix && w != word_at_cursor && w.downcase.start_with?(prefix_downcase)
      end
      candidates.to_a.sort.first(MAX_CANDIDATES)
    end

    # Get the full word at cursor position (for exclusion)
    def word_at_position(row, col)
      line = @buffer.line(row)
      return nil if line.empty?

      # Find word boundaries
      start_col = col
      start_col -= 1 while start_col.positive? && word_char?(line[start_col - 1])

      end_col = col
      end_col += 1 while end_col < line.length && word_char?(line[end_col])

      word = line[start_col...end_col]
      word && word.length >= MIN_WORD_LENGTH ? word : nil
    end

    # Mark a row as dirty (needs re-scanning)
    def mark_dirty(row)
      @dirty_rows << row
    end

    # Add a word directly (for incremental updates)
    def add_word(word)
      @words << word if word.length >= MIN_WORD_LENGTH
    end

    # Get the word prefix at cursor position
    def prefix_at(row, col)
      line = @buffer.line(row)
      return "" if col.zero? || line.empty?

      start_col = col
      start_col -= 1 while start_col.positive? && word_char?(line[start_col - 1])

      line[start_col...col] || ""
    end

    private

    # Regex to match word characters (alphanumeric + underscore)
    WORD_REGEX = /\w+/

    def build_cache
      @buffer.lines.each do |line|
        extract_words_fast(line)
      end
    end

    def process_dirty_rows(exclude_row, exclude_col)
      return if @dirty_rows.empty?

      @dirty_rows.each do |row|
        next if row >= @buffer.line_count

        line = @buffer.line(row)
        extract_words_with_exclusion(line, exclude_row, exclude_col, row)
      end
      @dirty_rows.clear
    end

    # Fast word extraction using scan (for initial cache build)
    def extract_words_fast(line)
      line.scan(WORD_REGEX) do |word|
        @words << word if word.length >= MIN_WORD_LENGTH
      end
    end

    # Word extraction with cursor position exclusion (for dirty row processing)
    def extract_words_with_exclusion(line, exclude_row, exclude_col, current_row)
      line.scan(WORD_REGEX) do |word|
        next if word.length < MIN_WORD_LENGTH

        # Get match position
        match = Regexp.last_match
        word_start = match.begin(0)
        word_end = match.end(0)

        # Skip word at cursor position
        next if exclude_row && current_row == exclude_row && word_start <= exclude_col && word_end > exclude_col

        @words << word
      end
    end

    def word_char?(char)
      # Direct character check is faster than regex for single chars
      return false unless char

      c = char.ord
      c.between?(48, 57) || # 0-9
        c.between?(65, 90) ||  # A-Z
        c.between?(97, 122) || # a-z
        c == 95 # _
    end
  end
end
