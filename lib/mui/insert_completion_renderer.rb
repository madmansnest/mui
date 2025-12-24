# frozen_string_literal: true

module Mui
  # Renders completion popup for Insert mode (LSP completions)
  class InsertCompletionRenderer
    MAX_VISIBLE_ITEMS = 10

    def initialize(screen, color_scheme)
      @screen = screen
      @color_scheme = color_scheme
    end

    def render(completion_state, cursor_row, cursor_col)
      return unless completion_state.active?

      items = completion_state.items
      selected_index = completion_state.selected_index

      # Calculate visible window
      visible_start, visible_end = calculate_visible_range(items.length, selected_index)
      visible_items = items[visible_start...visible_end]

      # Calculate popup dimensions
      max_width = calculate_max_width(visible_items)
      popup_height = visible_items.length

      # Calculate position (popup appears below the cursor)
      popup_row = cursor_row + 1
      popup_col = cursor_col

      # If popup would go below screen, show above cursor instead
      popup_row = cursor_row - popup_height if popup_row + popup_height > @screen.height - 1

      # Ensure popup stays within screen bounds
      popup_col = [@screen.width - max_width - 1, popup_col].min
      popup_col = [0, popup_col].max
      popup_row = [0, popup_row].max

      # Render each visible item
      visible_items.each_with_index do |item, i|
        actual_index = visible_start + i
        is_selected = actual_index == selected_index

        render_item(
          item,
          popup_row + i,
          popup_col,
          max_width,
          is_selected
        )
      end
    end

    private

    def calculate_visible_range(total_count, selected_index)
      return [0, total_count] if total_count <= MAX_VISIBLE_ITEMS

      # Try to center the selected item
      half = MAX_VISIBLE_ITEMS / 2
      start_index = selected_index - half
      start_index = [0, start_index].max
      end_index = start_index + MAX_VISIBLE_ITEMS
      end_index = [total_count, end_index].min
      start_index = end_index - MAX_VISIBLE_ITEMS

      [start_index, end_index]
    end

    def calculate_max_width(items)
      return 0 if items.empty?

      items.reduce(0) { |max, item| [max, display_width(item_label(item))].max } + 2 # +2 for padding
    end

    def item_label(item)
      item[:label] || item.to_s
    end

    def display_width(text)
      UnicodeWidth.string_width(text)
    end

    def render_item(item, row, col, width, selected)
      style_key = selected ? :completion_popup_selected : :completion_popup
      style = @color_scheme[style_key]
      label = item_label(item)
      padded_text = " #{label}".ljust(width)
      @screen.put_with_style(row, col, padded_text, style)
    end
  end
end
