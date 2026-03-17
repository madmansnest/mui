# frozen_string_literal: true

require_relative "test_helper"

class TestTtyCommand < Minitest::Test
  def setup
    Mui.reset_config!
  end

  class TestCommandContextTty < TestTtyCommand
    def test_run_tty_command_return_hash
      runner = ScriptRunner.new
      editor = runner.editor
      adapter = editor.instance_variable_get(:@adapter)

      adapter.define_singleton_method(:suspend) { nil }
      adapter.define_singleton_method(:resume) { nil }

      context = Mui::CommandContext.new(
        editor:,
        buffer: editor.buffer,
        window: editor.window
      )
      context.define_singleton_method(:wait_for_tty_command_return) { nil }

      result = context.run_tty_command("true")

      assert_kind_of Hash, result
      assert result.key?(:exit_status)
      assert result.key?(:success)
    end

    def test_run_tty_command_waits_before_resume
      runner = ScriptRunner.new
      editor = runner.editor
      adapter = editor.instance_variable_get(:@adapter)

      call_order = []
      adapter.define_singleton_method(:suspend) { call_order << :suspend }
      adapter.define_singleton_method(:resume) { call_order << :resume }

      context = Mui::CommandContext.new(
        editor:,
        buffer: editor.buffer,
        window: editor.window
      )
      context.define_singleton_method(:wait_for_tty_command_return) { call_order << :wait }

      context.run_tty_command("true")

      assert_equal %i[suspend wait resume], call_order
    end

    def test_run_tty_command_handles_failure
      runner = ScriptRunner.new
      editor = runner.editor
      adapter = editor.instance_variable_get(:@adapter)

      adapter.define_singleton_method(:suspend) { nil }
      adapter.define_singleton_method(:resume) { nil }

      context = Mui::CommandContext.new(
        editor:,
        buffer: editor.buffer,
        window: editor.window
      )
      context.define_singleton_method(:wait_for_tty_command_return) { nil }

      result = context.run_tty_command("false")

      refute result[:success]
      assert_equal 1, result[:exit_status]
    end
  end
end
