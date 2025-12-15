---
title: Getting Started
layout: default
nav_order: 2
---

# Getting Started
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Installation

Install Mui from RubyGems:

```bash
gem install mui
```

### Requirements

- Ruby 3.0 or later
- A terminal that supports 256 colors

## Basic Usage

### Opening a File

```bash
mui filename.rb
```

### Creating a New File

```bash
mui
```

Or open a non-existent file path:

```bash
mui new_file.rb
```

## Modes

Mui is a modal editor, similar to Vim. Understanding modes is essential.

### Normal Mode

The default mode. Used for navigation and commands.

- Press `Esc` from any mode to return to Normal mode

### Insert Mode

For typing text. Enter from Normal mode with:

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Append after cursor |
| `o` | Open new line below |
| `O` | Open new line above |

### Visual Mode

For selecting text:

| Key | Action |
|-----|--------|
| `v` | Character-wise selection |
| `V` | Line-wise selection |

### Command Mode

For Ex commands. Press `:` from Normal mode.

## Essential Commands

### Saving and Quitting

| Command | Action |
|---------|--------|
| `:w` | Save file |
| `:q` | Quit (fails if unsaved changes) |
| `:q!` | Force quit without saving |
| `:wq` | Save and quit |

### Opening Files

| Command | Action |
|---------|--------|
| `:e filename` | Open file |
| `:sp filename` | Open in horizontal split |
| `:vs filename` | Open in vertical split |
| `:tabnew filename` | Open in new tab |

### Navigation

| Key | Action |
|-----|--------|
| `h`, `j`, `k`, `l` | Left, down, up, right |
| `w`, `b` | Word forward, backward |
| `0`, `$` | Line start, end |
| `gg`, `G` | File start, end |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n`, `N` | Next, previous match |

## Configuration

Create `~/.muirc` for global settings:

```ruby
# Set color scheme
Mui.set :colorscheme, "tokyo_night"

# Enable syntax highlighting
Mui.set :syntax, true

# Set indentation
Mui.set :tabstop, 2
Mui.set :shiftwidth, 2
Mui.set :expandtab, true
```

See [Configuration]({{ site.baseurl }}/configuration) for all options.

## Next Steps

- [Key Bindings]({{ site.baseurl }}/keybindings) - Complete key reference
- [Configuration]({{ site.baseurl }}/configuration) - Customize Mui
- [Plugins]({{ site.baseurl }}/plugins) - Extend functionality
