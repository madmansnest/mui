# frozen_string_literal: true

require "test_helper"

class TestWindowCommand < Minitest::Test
  def setup
    @screen = Mui::TerminalAdapter::Test.new(width: 80, height: 24)
    @buffer = Mui::Buffer.new
    @window_manager = Mui::WindowManager.new(@screen)
    @window_manager.add_window(@buffer)
    @command = Mui::KeyHandler::WindowCommand.new(@window_manager)
  end

  class TestSplitHorizontal < TestWindowCommand
    def test_s_splits_horizontally
      result = @command.handle("s")

      assert_equal :split_horizontal, result
      assert_equal 2, @window_manager.window_count
    end
  end

  class TestSplitVertical < TestWindowCommand
    def test_v_splits_vertically
      result = @command.handle("v")

      assert_equal :split_vertical, result
      assert_equal 2, @window_manager.window_count
    end
  end

  class TestFocusDirection < TestWindowCommand
    def setup
      super
      @window_manager.split_vertical
      @window_manager.focus_previous
    end

    def test_h_focuses_left
      @window_manager.focus_direction(:right)
      result = @command.handle("h")

      assert_equal :focus_left, result
    end

    def test_H_focuses_left
      @window_manager.focus_direction(:right)
      result = @command.handle("H")

      assert_equal :focus_left, result
    end

    def test_l_focuses_right
      result = @command.handle("l")

      assert_equal :focus_right, result
    end

    def test_L_focuses_right
      result = @command.handle("L")

      assert_equal :focus_right, result
    end
  end

  class TestFocusVerticalDirection < TestWindowCommand
    def setup
      super
      @window_manager.split_horizontal
      @window_manager.focus_previous
    end

    def test_j_focuses_down
      result = @command.handle("j")

      assert_equal :focus_down, result
    end

    def test_J_focuses_down
      result = @command.handle("J")

      assert_equal :focus_down, result
    end

    def test_k_focuses_up
      @window_manager.focus_direction(:down)
      result = @command.handle("k")

      assert_equal :focus_up, result
    end

    def test_K_focuses_up
      @window_manager.focus_direction(:down)
      result = @command.handle("K")

      assert_equal :focus_up, result
    end
  end

  class TestFocusCycle < TestWindowCommand
    def setup
      super
      @window_manager.split_horizontal
    end

    def test_w_focuses_next
      result = @command.handle("w")

      assert_equal :focus_next, result
    end

    def test_W_focuses_previous
      result = @command.handle("W")

      assert_equal :focus_previous, result
    end
  end

  class TestCloseWindow < TestWindowCommand
    def setup
      super
      @window_manager.split_horizontal
    end

    def test_c_closes_current_window
      result = @command.handle("c")

      assert_equal :close_window, result
      assert_equal 1, @window_manager.window_count
    end

    def test_q_closes_current_window
      result = @command.handle("q")

      assert_equal :close_window, result
      assert_equal 1, @window_manager.window_count
    end

    def test_c_cannot_close_single_window
      @window_manager.close_current_window
      result = @command.handle("c")

      assert_equal :close_window, result
      assert_equal 1, @window_manager.window_count
    end
  end

  class TestCloseAllExceptCurrent < TestWindowCommand
    def setup
      super
      @window_manager.split_horizontal
      @window_manager.split_vertical
    end

    def test_o_closes_all_except_current
      result = @command.handle("o")

      assert_equal :close_all_except_current, result
      assert_equal 1, @window_manager.window_count
    end
  end

  class TestUnknownKey < TestWindowCommand
    def test_unknown_key_returns_done
      result = @command.handle("x")

      assert_equal :done, result
    end

    def test_invalid_key_returns_done
      result = @command.handle(9999)

      assert_equal :done, result
    end
  end

  # Tests for Ctrl+key combinations (Ctrl held down while pressing second key)
  class TestControlKeyCombinations < TestWindowCommand
    def test_ctrl_s_splits_horizontally
      result = @command.handle(Mui::KeyCode::CTRL_S)

      assert_equal :split_horizontal, result
      assert_equal 2, @window_manager.window_count
    end

    def test_ctrl_v_splits_vertically
      result = @command.handle(Mui::KeyCode::CTRL_V)

      assert_equal :split_vertical, result
      assert_equal 2, @window_manager.window_count
    end

    def test_ctrl_h_focuses_left
      @window_manager.split_vertical
      result = @command.handle(Mui::KeyCode::CTRL_H)

      assert_equal :focus_left, result
    end

    def test_ctrl_j_focuses_down
      @window_manager.split_horizontal
      @window_manager.focus_previous
      result = @command.handle(Mui::KeyCode::CTRL_J)

      assert_equal :focus_down, result
    end

    def test_ctrl_k_focuses_up
      @window_manager.split_horizontal
      result = @command.handle(Mui::KeyCode::CTRL_K)

      assert_equal :focus_up, result
    end

    def test_ctrl_l_focuses_right
      @window_manager.split_vertical
      @window_manager.focus_previous
      result = @command.handle(Mui::KeyCode::CTRL_L)

      assert_equal :focus_right, result
    end

    def test_ctrl_w_focuses_next
      @window_manager.split_horizontal
      result = @command.handle(Mui::KeyCode::CTRL_W)

      assert_equal :focus_next, result
    end

    def test_ctrl_c_closes_window
      @window_manager.split_horizontal
      result = @command.handle(Mui::KeyCode::CTRL_C)

      assert_equal :close_window, result
      assert_equal 1, @window_manager.window_count
    end

    def test_ctrl_o_closes_all_except_current
      @window_manager.split_horizontal
      @window_manager.split_vertical
      result = @command.handle(Mui::KeyCode::CTRL_O)

      assert_equal :close_all_except_current, result
      assert_equal 1, @window_manager.window_count
    end
  end
end
