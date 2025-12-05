# frozen_string_literal: true

require "test_helper"

class TestColorManager < Minitest::Test
  def setup
    @manager = Mui::ColorManager.new
  end

  def test_register_pair
    pair1 = @manager.register_pair(:white, :black)
    assert_equal 1, pair1
  end

  def test_register_same_pair_returns_same_index
    pair1 = @manager.register_pair(:white, :black)
    pair2 = @manager.register_pair(:white, :black)
    assert_equal pair1, pair2
  end

  def test_register_different_pairs_returns_different_indices
    pair1 = @manager.register_pair(:white, :black)
    pair2 = @manager.register_pair(:black, :white)
    refute_equal pair1, pair2
  end

  def test_get_pair_index
    @manager.register_pair(:red, :blue)
    pair_index = @manager.get_pair_index(:red, :blue)
    assert_equal 1, pair_index
  end

  def test_color_map
    assert_equal 0, Mui::ColorManager::COLOR_MAP[:black]
    assert_equal 1, Mui::ColorManager::COLOR_MAP[:red]
    assert_equal 2, Mui::ColorManager::COLOR_MAP[:green]
    assert_equal 3, Mui::ColorManager::COLOR_MAP[:yellow]
    assert_equal 4, Mui::ColorManager::COLOR_MAP[:blue]
    assert_equal 5, Mui::ColorManager::COLOR_MAP[:magenta]
    assert_equal 6, Mui::ColorManager::COLOR_MAP[:cyan]
    assert_equal 7, Mui::ColorManager::COLOR_MAP[:white]
  end
end
