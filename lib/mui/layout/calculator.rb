# frozen_string_literal: true

module Mui
  module Layout
    class Calculator
      def calculate(root, x, y, width, height)
        root.x = x
        root.y = y
        root.width = width
        root.height = height
        root.apply_geometry
      end
    end
  end
end
