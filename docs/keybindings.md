---
title: Key Bindings
layout: default
nav_order: 3
---

# Key Bindings
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Normal Mode

### Cursor Movement

| Key | Action |
|-----|--------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `0` | Move to line start |
| `^` | Move to first non-blank character |
| `$` | Move to line end |
| `Shift-Left` | Move to end of previous line |
| `Shift-Right` | Move to start of next line |

### Word Movement

| Key | Action |
|-----|--------|
| `w` | Move to next word start |
| `b` | Move to previous word start |
| `e` | Move to word end |

### File Movement

| Key | Action |
|-----|--------|
| `gg` | Go to first line |
| `G` | Go to last line |
| `:{number}` | Go to line number |

### Character Search

| Key | Action |
|-----|--------|
| `f{char}` | Find character forward (on character) |
| `F{char}` | Find character backward (on character) |
| `t{char}` | Find character forward (before character) |
| `T{char}` | Find character backward (after character) |

### Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor (forward) |
| `#` | Search word under cursor (backward) |

### Entering Insert Mode

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `a` | Append after cursor |
| `I` | Insert at line start |
| `A` | Append at line end |
| `o` | Open line below |
| `O` | Open line above |

### Operators

Operators can be combined with motions (e.g., `dw` = delete word).

| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete and enter Insert mode) |
| `y` | Yank (copy) |

### Common Operations

| Key | Action |
|-----|--------|
| `dd` | Delete line |
| `cc` | Change line |
| `yy` | Yank line |
| `x` | Delete character at cursor |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `Ctrl-r` | Redo |

### Visual Mode

| Key | Action |
|-----|--------|
| `v` | Enter Visual mode |
| `V` | Enter Visual Line mode |
| `gv` | Reselect last visual selection |

### Tabs and Windows

| Key | Action |
|-----|--------|
| `gt` | Go to next tab |
| `gT` | Go to previous tab |
| `Ctrl-w h` | Go to left window |
| `Ctrl-w j` | Go to below window |
| `Ctrl-w k` | Go to above window |
| `Ctrl-w l` | Go to right window |
| `Ctrl-w w` | Cycle to next window |
| `Ctrl-w c` | Close current window |
| `Ctrl-w o` | Close all other windows |

### Registers

| Key | Action |
|-----|--------|
| `"a` - `"z` | Use named register |
| `""` | Use unnamed register |
| `"0` | Use yank register |
| `"1` - `"9` | Use delete history |
| `"_` | Use black hole register (discard) |

Example: `"ayy` yanks line to register `a`, `"ap` pastes from register `a`.

---

## Insert Mode

| Key | Action |
|-----|--------|
| `Esc` | Return to Normal mode |
| `Ctrl-n` | Next completion candidate |
| `Ctrl-p` | Previous completion candidate |
| `Tab` | Accept completion |
| Arrow keys | Move cursor |
| `Shift-Left` | Move to end of previous line |
| `Shift-Right` | Move to start of next line |
| `Backspace` | Delete character before cursor |

---

## Visual Mode

| Key | Action |
|-----|--------|
| `Esc` | Return to Normal mode |
| `d` | Delete selection |
| `c` | Change selection |
| `y` | Yank selection |
| `>` | Indent selection |
| `<` | Unindent selection |
| `*` | Search for selected text (forward) |
| `#` | Search for selected text (backward) |
| All motion keys | Extend selection |

---

## Command Mode

Enter with `:` from Normal mode.

### File Commands

| Command | Action |
|---------|--------|
| `:w` | Save file |
| `:w filename` | Save as filename |
| `:q` | Quit |
| `:q!` | Force quit |
| `:wq` | Save and quit |
| `:e filename` | Open file |

### Window Commands

| Command | Action |
|---------|--------|
| `:sp [filename]` | Horizontal split |
| `:vs [filename]` | Vertical split |
| `:close` | Close window |
| `:only` | Close all other windows |

### Tab Commands

| Command | Action |
|---------|--------|
| `:tabnew [filename]` | New tab |
| `:tabclose` | Close tab |
| `:tabnext` | Next tab |
| `:tabprev` | Previous tab |
| `:tabfirst` | First tab |
| `:tablast` | Last tab |
| `:tabmove N` | Move tab to position N |

### Shell Commands

| Command | Action |
|---------|--------|
| `:!cmd` | Run shell command |

### Navigation

| Command | Action |
|---------|--------|
| `:{number}` | Go to line number |

---

## Search Mode

Enter with `/` or `?` from Normal mode.

| Key | Action |
|-----|--------|
| `Enter` | Execute search |
| `Esc` | Cancel search |
| `Tab` | Cycle through completion |
| `Shift-Tab` | Cycle backward |
| `Backspace` | Delete character |

Search supports regular expressions.
