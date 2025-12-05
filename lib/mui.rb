# frozen_string_literal: true

require_relative "mui/version"
require_relative "mui/error"
require_relative "mui/key_code"
require_relative "mui/config"
require_relative "mui/color_scheme"
require_relative "mui/color_manager"
require_relative "mui/themes/default"
require_relative "mui/terminal_adapter"
require_relative "mui/screen"
require_relative "mui/input"
require_relative "mui/undoable_action"
require_relative "mui/undo_manager"
require_relative "mui/buffer"
require_relative "mui/window"
require_relative "mui/mode"
require_relative "mui/handler_result"
require_relative "mui/command_line"
require_relative "mui/search_state"
require_relative "mui/search_input"
require_relative "mui/motion"
require_relative "mui/selection"
require_relative "mui/register"
require_relative "mui/key_handler"
require_relative "mui/mode_manager"
require_relative "mui/editor"

# mui(無為) top level module
module Mui
  class << self
    def config
      @config ||= Config.new
    end

    def set(key, value)
      config.set(key, value)
    end

    def use(gem_name, version = nil)
      # Phase 3.1ではスタブ実装
      # 将来的にgem require + プラグイン登録
      config.use_plugin(gem_name, version)
    end

    def keymap(mode, key, &block)
      # Phase 3.1ではスタブ実装
      config.add_keymap(mode, key, block)
    end

    def load_config
      config.load_file(File.expand_path("~/.muirc"))
      config.load_file(".lmuirc")
    end

    def reset_config!
      @config = nil
    end
  end
end
