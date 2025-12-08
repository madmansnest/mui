# frozen_string_literal: true

require "test_helper"

class TestCalculator < Minitest::Test
  def setup
    @calculator = Mui::Layout::Calculator.new
    @buffer = Mui::Buffer.new
    @window = Mui::Window.new(@buffer)
    @leaf = Mui::Layout::LeafNode.new(@window)
  end

  def test_calculate_sets_root_geometry
    @calculator.calculate(@leaf, 10, 20, 80, 24)

    assert_equal 10, @leaf.x
    assert_equal 20, @leaf.y
    assert_equal 80, @leaf.width
    assert_equal 24, @leaf.height
  end

  def test_calculate_applies_geometry_to_window
    @calculator.calculate(@leaf, 10, 20, 80, 24)

    assert_equal 10, @window.x
    assert_equal 20, @window.y
    assert_equal 80, @window.width
    assert_equal 24, @window.height
  end

  def test_calculate_with_split_node
    buffer2 = Mui::Buffer.new
    window2 = Mui::Window.new(buffer2)
    leaf2 = Mui::Layout::LeafNode.new(window2)

    split = Mui::Layout::SplitNode.new(
      direction: :horizontal,
      children: [@leaf, leaf2],
      ratio: 0.5
    )

    @calculator.calculate(split, 0, 0, 80, 24)

    # height 24 - separator 1 = 23 available, split 50% = 11 + 12
    # First window: top half
    assert_equal 0, @window.x
    assert_equal 0, @window.y
    assert_equal 80, @window.width
    assert_equal 11, @window.height

    # Second window: bottom half (after separator at y=11)
    assert_equal 0, window2.x
    assert_equal 12, window2.y # 11 + 1 (separator)
    assert_equal 80, window2.width
    assert_equal 12, window2.height
  end
end
