# frozen_string_literal: true

module Mui
  class Config
    attr_reader :options, :plugins, :keymaps

    def initialize
      @options = {
        colorscheme: "mui"
      }
      @plugins = []
      @keymaps = {}
    end

    def set(key, value)
      @options[key.to_sym] = value
    end

    def get(key)
      @options[key.to_sym]
    end

    def load_file(path)
      return unless File.exist?(path)

      instance_eval(File.read(path), path)
    end

    # Stub for future plugin support
    def use_plugin(gem_name, version = nil)
      @plugins << { gem: gem_name, version: version }
    end

    # Stub for future keymap support
    def add_keymap(mode, key, block)
      @keymaps[mode] ||= {}
      @keymaps[mode][key] = block
    end
  end
end
