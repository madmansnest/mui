# frozen_string_literal: true

module Mui
  module Layout
    class LeafNode < Node
      attr_accessor :window

      def initialize(window)
        super()
        @window = window
      end

      def leaf?
        true
      end

      def windows
        [@window]
      end

      def find_window_node(target_window)
        @window == target_window ? self : nil
      end

      def apply_geometry
        @window.x = @x
        @window.y = @y
        @window.width = @width
        @window.height = @height
      end
    end
  end
end
