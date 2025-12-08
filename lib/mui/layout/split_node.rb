# frozen_string_literal: true

module Mui
  module Layout
    class SplitNode < Node
      SEPARATOR_SIZE = 1

      attr_accessor :direction, :children, :ratio

      def initialize(direction:, children: [], ratio: 0.5)
        super()
        @direction = direction
        @children = children
        @ratio = ratio
        children.each { |c| c.parent = self }
      end

      def separators
        result = []
        collect_separators(result)
        result
      end

      def split?
        true
      end

      def windows
        @children.flat_map(&:windows)
      end

      def find_window_node(target_window)
        @children.each do |child|
          result = child.find_window_node(target_window)
          return result if result
        end
        nil
      end

      def apply_geometry
        return if @children.empty?

        if @children.size == 1
          apply_single_child
        else
          apply_split_children
        end

        @children.each(&:apply_geometry)
      end

      def replace_child(old_child, new_child)
        index = @children.index(old_child)
        return unless index

        @children[index] = new_child
        new_child.parent = self
      end

      def remove_child(child)
        @children.delete(child)
      end

      private

      def apply_single_child
        child = @children.first
        child.x = @x
        child.y = @y
        child.width = @width
        child.height = @height
      end

      def apply_split_children
        case @direction
        when :horizontal
          apply_horizontal_split
        when :vertical
          apply_vertical_split
        end
      end

      def apply_horizontal_split
        available_height = @height - SEPARATOR_SIZE
        first_height = (available_height * @ratio).to_i
        second_height = available_height - first_height

        @children[0].x = @x
        @children[0].y = @y
        @children[0].width = @width
        @children[0].height = first_height

        @children[1].x = @x
        @children[1].y = @y + first_height + SEPARATOR_SIZE
        @children[1].width = @width
        @children[1].height = second_height
      end

      def apply_vertical_split
        available_width = @width - SEPARATOR_SIZE
        first_width = (available_width * @ratio).to_i
        second_width = available_width - first_width

        @children[0].x = @x
        @children[0].y = @y
        @children[0].width = first_width
        @children[0].height = @height

        @children[1].x = @x + first_width + SEPARATOR_SIZE
        @children[1].y = @y
        @children[1].width = second_width
        @children[1].height = @height
      end

      def collect_separators(result)
        return if @children.size < 2

        if @direction == :horizontal
          separator_y = @children[0].y + @children[0].height
          result << { type: :horizontal, x: @x, y: separator_y, length: @width }
        else
          separator_x = @children[0].x + @children[0].width
          result << { type: :vertical, x: separator_x, y: @y, length: @height }
        end

        @children.each do |child|
          child.send(:collect_separators, result) if child.respond_to?(:collect_separators, true)
        end
      end
    end
  end
end
