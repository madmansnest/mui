# frozen_string_literal: true

module Mui
  module KeyHandler
    class WindowCommand
      def initialize(window_manager)
        @window_manager = window_manager
      end

      def handle(key)
        if key.is_a?(Integer)
          result = handle_control_key(key)
          return result if result
        end

        char = key_to_char(key)
        return :done unless char

        case char
        when "s"
          handle_split_horizontal
        when "v"
          handle_split_vertical
        when "h", "H"
          handle_focus_direction(:left)
        when "j", "J"
          handle_focus_direction(:down)
        when "k", "K"
          handle_focus_direction(:up)
        when "l", "L"
          handle_focus_direction(:right)
        when "w"
          handle_focus_next
        when "W"
          handle_focus_previous
        when "c", "q"
          handle_close_window
        when "o"
          handle_close_all_except_current
        else
          :done
        end
      end

      private

      def handle_control_key(key)
        case key
        when KeyCode::CTRL_S
          handle_split_horizontal
        when KeyCode::CTRL_V
          handle_split_vertical
        when KeyCode::CTRL_H
          handle_focus_direction(:left)
        when KeyCode::CTRL_J
          handle_focus_direction(:down)
        when KeyCode::CTRL_K
          handle_focus_direction(:up)
        when KeyCode::CTRL_L
          handle_focus_direction(:right)
        when KeyCode::CTRL_W
          handle_focus_next
        when KeyCode::CTRL_C
          handle_close_window
        when KeyCode::CTRL_O
          handle_close_all_except_current
        end
      end

      def key_to_char(key)
        key.is_a?(String) ? key : key.chr
      rescue RangeError
        nil
      end

      def handle_split_horizontal
        @window_manager.split_horizontal
        :split_horizontal
      end

      def handle_split_vertical
        @window_manager.split_vertical
        :split_vertical
      end

      def handle_focus_direction(direction)
        @window_manager.focus_direction(direction)
        :"focus_#{direction}"
      end

      def handle_focus_next
        @window_manager.focus_next
        :focus_next
      end

      def handle_focus_previous
        @window_manager.focus_previous
        :focus_previous
      end

      def handle_close_window
        @window_manager.close_current_window
        :close_window
      end

      def handle_close_all_except_current
        @window_manager.close_all_except_current
        :close_all_except_current
      end
    end
  end
end
