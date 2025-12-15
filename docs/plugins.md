---
title: Plugins
layout: default
nav_order: 5
---

# Plugins
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Mui's plugin system allows you to extend the editor's functionality using Ruby gems. Plugins can:

- Add custom commands
- Define key mappings
- React to events (autocmd)
- Integrate with external tools
- Add syntax highlighting

## Official Plugins

| Plugin | Description | Install |
|--------|-------------|---------|
| [mui-lsp](https://github.com/S-H-GAMELINKS/mui-lsp) | LSP support | `gem install mui-lsp` |
| [mui-git](https://github.com/S-H-GAMELINKS/mui-git) | Git integration | `gem install mui-git` |
| [mui-fzf](https://github.com/S-H-GAMELINKS/mui-fzf) | fzf integration | `gem install mui-fzf` |

## Using Plugins

### Loading Plugins

Add plugins to your `~/.muirc`:

```ruby
Mui.use "mui-lsp"
Mui.use "mui-git"
Mui.use "mui-fzf"
```

Plugins are automatically installed via `bundler/inline` on first startup.

### LSP Configuration

Configure LSP servers with `Mui.lsp`:

```ruby
Mui.use "mui-lsp"

Mui.lsp do
  # Use preset configuration
  use :ruby

  # Custom server configuration
  server :typescript,
    command: ["typescript-language-server", "--stdio"],
    filetypes: ["typescript", "typescriptreact"]
end
```

---

## Creating Plugins

### Class-based Plugin

```ruby
class MyPlugin < Mui::Plugin
  name :my_plugin
  version "1.0.0"
  description "My awesome plugin"

  # Optional: declare dependencies
  depends_on :other_plugin

  def setup
    # Define commands, keymaps, autocmds here
  end
end
```

### DSL-based Plugin

```ruby
Mui.define_plugin(:my_plugin) do
  # Define commands, keymaps, autocmds here
end
```

---

## Plugin API

### Commands

```ruby
def setup
  command :greet do |ctx|
    ctx.set_message("Hello!")
  end

  command :greet_name do |ctx, name|
    ctx.set_message("Hello, #{name}!")
  end
end
```

### Key Mappings

```ruby
def setup
  # Normal mode mapping
  keymap :normal, "<Leader>g" do |ctx|
    ctx.editor.execute_command("greet")
  end

  # Insert mode mapping
  keymap :insert, "<C-g>" do |ctx|
    ctx.insert_text("Generated text")
  end

  # Multi-key sequence
  keymap :normal, "<Leader>gg" do |ctx|
    ctx.set_message("Leader g g pressed!")
  end
end
```

### Autocmd Events

```ruby
def setup
  autocmd :BufEnter, pattern: "*.rb" do |ctx|
    ctx.set_message("Opened Ruby file: #{ctx.buffer.file_path}")
  end

  autocmd :BufWritePre do |ctx|
    # Run before every file save
  end

  autocmd :InsertLeave do |ctx|
    # Run when leaving insert mode
  end
end
```

---

## CommandContext API

The `ctx` object passed to handlers provides access to editor internals:

### Messages

```ruby
ctx.set_message("Info message")
ctx.set_error("Error message")
```

### Editor Access

```ruby
ctx.editor                    # Editor instance
ctx.buffer                    # Current buffer
ctx.window                    # Current window
ctx.mode                      # Current mode (:normal, :insert, etc.)
```

### Mode Control

```ruby
ctx.change_mode(:normal)
ctx.change_mode(:insert)
```

### Text Manipulation

```ruby
ctx.insert_text("text")       # Insert at cursor
ctx.buffer.lines              # Get all lines
ctx.buffer.line(n)            # Get line n
```

### Cursor

```ruby
ctx.cursor_row                # Current row (0-indexed)
ctx.cursor_col                # Current column (0-indexed)
ctx.move_cursor(row, col)     # Move cursor
```

### File Operations

```ruby
ctx.buffer.file_path          # Current file path
ctx.buffer.modified?          # Has unsaved changes?
ctx.editor.execute_command("w")   # Save file
ctx.editor.execute_command("e filename")  # Open file
```

### Scratch Buffers

```ruby
ctx.open_scratch_buffer("[Results]", "Content here")
```

### Jobs

See [Jobs]({{ site.baseurl }}/jobs) for async job execution.

### Interactive Commands

```ruby
if ctx.command_exists?("fzf")
  result = ctx.run_interactive_command("fzf")
  ctx.editor.execute_command("e #{result}") if result
end
```

---

## Publishing Plugins

### Gem Structure

```
mui-myplugin/
├── lib/
│   └── mui_myplugin.rb
├── mui-myplugin.gemspec
└── README.md
```

### Gemspec

```ruby
Gem::Specification.new do |spec|
  spec.name          = "mui-myplugin"
  spec.version       = "1.0.0"
  spec.summary       = "My Mui plugin"
  spec.files         = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "mui", ">= 0.2.0"
end
```

### Plugin File

```ruby
# lib/mui_myplugin.rb
require "mui"

class MuiMyplugin < Mui::Plugin
  name :myplugin
  version "1.0.0"

  def setup
    command :my_command do |ctx|
      ctx.set_message("Hello from myplugin!")
    end
  end
end
```

### Publishing

```bash
gem build mui-myplugin.gemspec
gem push mui-myplugin-1.0.0.gem
```

Users can then install with:

```ruby
# ~/.muirc
Mui.use "mui-myplugin"
```
