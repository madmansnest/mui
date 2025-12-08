# frozen_string_literal: true

module Mui
  module Layout
    class Node
      attr_accessor :parent, :x, :y, :width, :height

      def leaf?
        false
      end

      def split?
        false
      end

      def windows
        raise Mui::MethodNotOverriddenError, :windows
      end

      def find_window_node(_window)
        raise Mui::MethodNotOverriddenError, :find_window_node
      end

      def apply_geometry
        raise Mui::MethodNotOverriddenError, :apply_geometry
      end
    end
  end
end
