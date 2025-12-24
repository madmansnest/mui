# frozen_string_literal: true

module Mui
  # Provides file path completion
  class FileCompleter
    def complete(partial_path)
      return list_current_directory if partial_path.empty?

      dir, prefix = split_path(partial_path)
      entries = list_directory(dir)

      entries.filter_map do |entry|
        format_entry_to_path(dir, entry) if entry.start_with?(prefix)
      end
    end

    private

    def split_path(path)
      if path.end_with?("/")
        [path, ""]
      else
        dir = File.dirname(path)
        dir = "" if dir == "."
        [dir, File.basename(path)]
      end
    end

    def list_directory(dir)
      target = dir.empty? ? "." : dir
      return [] unless Dir.exist?(target)

      Dir.entries(target).sort
    end

    def list_current_directory
      list_directory("").map { |entry| format_path(entry) }
    end

    def format_path(path)
      full_path = path.start_with?("/") ? path : File.join(".", path)
      File.directory?(full_path) ? "#{path}/" : path
    end

    def format_entry_to_path(dir, entry)
      path = dir.empty? ? entry : File.join(dir, entry)

      format_path(path)
    end
  end
end
