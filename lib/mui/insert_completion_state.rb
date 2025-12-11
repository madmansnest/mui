# frozen_string_literal: true

module Mui
  # Manages Insert mode completion state for LSP completions
  class InsertCompletionState
    attr_reader :items, :selected_index, :prefix, :original_items

    def initialize
      reset
    end

    def reset
      @items = []
      @original_items = []
      @selected_index = 0
      @prefix = ""
    end

    def active?
      !@items.empty?
    end

    def start(items, prefix: "")
      @original_items = items.dup
      @items = items
      @selected_index = 0
      @prefix = prefix
    end

    # Update prefix and filter items based on new prefix
    def update_prefix(new_prefix)
      return if new_prefix == @prefix

      @prefix = new_prefix
      @items = @original_items.select do |item|
        label = item[:label] || item[:insert_text] || ""
        label.downcase.start_with?(new_prefix.downcase)
      end
      @selected_index = 0
    end

    def select_next
      return unless active?

      @selected_index = (@selected_index + 1) % @items.length
    end

    def select_previous
      return unless active?

      @selected_index = (@selected_index - 1) % @items.length
    end

    def current_item
      return nil unless active?

      @items[@selected_index]
    end

    # Returns the text to insert for the current item
    def insert_text
      return nil unless current_item

      item = current_item
      # Prefer textEdit.newText if available (text_edit value has string keys from LSP)
      item.dig(:text_edit, "newText") || item[:insert_text] || item[:label] || item.to_s
    end

    # Returns the textEdit range if available
    def text_edit_range
      return nil unless current_item

      # text_edit value has string keys from LSP
      current_item.dig(:text_edit, "range")
    end
  end
end
