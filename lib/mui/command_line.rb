# frozen_string_literal: true

module Mui
  class CommandLine
    attr_reader :buffer

    def initialize
      @buffer = ""
    end

    def input(char)
      @buffer += char
    end

    def backspace
      @buffer = @buffer.chop
    end

    def clear
      @buffer = ""
    end

    def execute
      result = parse(@buffer)
      @buffer = ""
      result
    end

    def to_s
      ":#{@buffer}"
    end

    private

    def parse(cmd)
      case cmd.strip
      when "e"
        { action: :open }
      when /^e\s+(.+)/
        { action: :open_as, path: ::Regexp.last_match(1) }
      when "w"
        { action: :write }
      when "q"
        { action: :quit }
      when "wq"
        { action: :write_quit }
      when "q!"
        { action: :force_quit }
      when /^w\s+(.+)/
        { action: :write_as, path: ::Regexp.last_match(1) }
      when "sp", "split"
        { action: :split_horizontal }
      when /^sp\s+(.+)/, /^split\s+(.+)/
        { action: :split_horizontal, path: ::Regexp.last_match(1) }
      when "vs", "vsplit"
        { action: :split_vertical }
      when /^vs\s+(.+)/, /^vsplit\s+(.+)/
        { action: :split_vertical, path: ::Regexp.last_match(1) }
      when "close"
        { action: :close_window }
      when "only"
        { action: :only_window }
      else
        { action: :unknown, command: cmd }
      end
    end
  end
end
