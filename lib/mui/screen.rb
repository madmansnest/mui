# frozen_string_literal: true

module Mui
  class Screen
    attr_reader :width, :height

    def initialize(adapter:, color_manager: nil)
      @adapter = adapter
      @color_manager = color_manager
      @initialized_pairs = {}
      @adapter.init
      update_size
    end

    def refresh
      update_size
      @adapter.refresh
    end

    def close
      @adapter.close
    end

    def clear
      @adapter.clear
    end

    def put(y, x, text)
      return if y.negative?
      return if y >= @height || x >= @width

      @adapter.setpos(y, x)
      max_len = @width - x
      @adapter.addstr(text.length > max_len ? text[0, max_len] : text)
    end

    def put_with_highlight(y, x, text)
      return if y.negative?
      return if y >= @height || x >= @width

      @adapter.setpos(y, x)
      max_len = @width - x
      @adapter.with_highlight do
        @adapter.addstr(text.length > max_len ? text[0, max_len] : text)
      end
    end

    def put_with_style(y, x, text, style)
      return if y.negative?
      return if y >= @height || x >= @width
      return put(y, x, text) unless @color_manager && style

      @adapter.setpos(y, x)
      max_len = @width - x
      truncated_text = text.length > max_len ? text[0, max_len] : text

      pair_index = ensure_color_pair(style[:fg], style[:bg])
      @adapter.with_color(pair_index, bold: style[:bold], underline: style[:underline]) do
        @adapter.addstr(truncated_text)
      end
    end

    def move_cursor(y, x)
      x = [[x, 0].max, @width - 1].min
      y = [[y, 0].max, @height - 1].min
      @adapter.setpos(y, x)
    end

    private

    def ensure_color_pair(fg, bg)
      pair_index = @color_manager.get_pair_index(fg, bg)
      unless @initialized_pairs[pair_index]
        @adapter.init_color_pair(pair_index, fg, bg)
        @initialized_pairs[pair_index] = true
      end
      pair_index
    end

    def update_size
      @width = @adapter.width
      @height = @adapter.height
    end
  end
end
