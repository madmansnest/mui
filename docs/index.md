---
title: Home
layout: home
nav_order: 1
---

# Mui (無為)

A Vim-like TUI text editor written in Ruby.
{: .fs-6 .fw-300 }

> **無為 (むい, mui)** - "Effortless action" from Taoist philosophy.
> *"Form without forcing, existing as it is. Yet from nothing, something is born."*

[Get Started]({{ site.baseurl }}/getting-started){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[View on GitHub](https://github.com/S-H-GAMELINKS/mui){: .btn .fs-5 .mb-4 .mb-md-0 .mr-2 }
[RubyGems](https://rubygems.org/gems/mui){: .btn .btn-green .fs-5 .mb-4 .mb-md-0 }

---

## Installation

```bash
gem install mui
```

## Features

- **Modal Editing** - Vim-like Normal, Insert, Visual, Command modes
- **Syntax Highlighting** - Ruby, C, Go, Rust, JavaScript, TypeScript, Markdown, HTML, CSS
- **Tab Pages & Window Splits** - Multiple files with flexible layouts
- **Plugin System** - Extend functionality with Ruby gems
- **LSP Support** - Language Server Protocol via mui-lsp plugin
- **Japanese/UTF-8 Support** - Full multibyte character support

## Quick Start

```bash
# Install from RubyGems
gem install mui

# Open a file
mui myfile.rb

# Or start with an empty buffer
mui
```

## Official Plugins

| Plugin | Description |
|--------|-------------|
| [mui-lsp](https://github.com/S-H-GAMELINKS/mui-lsp) | LSP (Language Server Protocol) support |
| [mui-git](https://github.com/S-H-GAMELINKS/mui-git) | Git integration |
| [mui-fzf](https://github.com/S-H-GAMELINKS/mui-fzf) | Fuzzy finder integration with fzf |
