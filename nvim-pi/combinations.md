# Neovim Keybindings Combinations

> **Note**: This list was automatically pulled from reading the entire Neovim configuration folder, including all `custom` and `kickstart` plugins, on **2026-08-15**.

Your **Leader Key** is mapped to `<Space>`.

## General & Window Navigation
| Shortcut | Mode | Action |
|----------|------|--------|
| `<Esc>` | Normal | Clear search highlighting (`:nohlsearch`) |
| `<Esc><Esc>` | Terminal | Exit terminal mode |
| `<leader>q` | Normal | Open the diagnostic Quickfix list |
| `<C-h>` | Normal | Move window focus Left |
| `<C-j>` | Normal | Move window focus Down |
| `<C-k>` | Normal | Move window focus Up |
| `<C-l>` | Normal | Move window focus Right |
| `<M-j>` | Normal | Navigate to the Next Quickfix error (Alt+j) |
| `<M-k>` | Normal | Navigate to the Previous Quickfix error (Alt+k) |
| `cc` | Normal | Quick-compile and run the current file in a split terminal (C, C++, Python, Shell) |
| `u` / `<C-r>` | Normal | Undo / Redo with visual highlighting (`highlight-undo.nvim`) |

## Telescope (Fuzzy Searching)
*Prefix: `<leader>s` (or just `<leader>`)*

| Shortcut | Action |
|----------|--------|
| `<leader>sf` | Search Files |
| `<leader>sg` | Search by Grep (search contents across files) |
| `<leader>sw` | Search the current Word under cursor |
| `<leader><leader>` | Find existing buffers |
| `<leader>/` | Fuzzily search within the current buffer |
| `<leader>s/` | Search in all Open Files |
| `<leader>sd` | Search Diagnostics |
| `<leader>sh` | Search Help tags |
| `<leader>sk` | Search Keymaps |
| `<leader>sc` | Search Commands |
| `<leader>s.` | Search Recent Files |
| `<leader>sr` | Search Resume (brings back the last search window) |
| `<leader>ss` | Search Select Telescope (builtin pickers) |
| `<leader>sn` | Search Neovim configuration files |

## LSP (Code Navigation & Actions)
*Prefix: `g`*

| Shortcut | Action |
|----------|--------|
| `grd` | Goto Definition |
| `grr` | Goto References |
| `gri` | Goto Implementation |
| `grt` | Goto Type Definition |
| `gO` | Open Document Symbols |
| `gW` | Open Workspace Symbols |
| `<leader>f` | Format the current buffer (via `conform.nvim`) |

## Git (Gitsigns)
*Prefix: `<leader>h`*

| Shortcut | Mode | Action |
|----------|------|--------|
| `]c` | Normal | Jump to next git change (hunk) |
| `[c` | Normal | Jump to previous git change (hunk) |
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage entire buffer |
| `<leader>hR` | Normal | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hi` | Normal | Preview hunk inline |
| `<leader>hb` | Normal | Blame line |
| `<leader>hd` | Normal | Diff against index |
| `<leader>hD` | Normal | Diff against last commit |
| `<leader>hq` | Normal | Git hunk Quickfix list (current file) |
| `<leader>hQ` | Normal | Git hunk Quickfix list (all files in repo) |

## Debugging (DAP)
| Shortcut | Action |
|----------|--------|
| `<F5>` | Start or Continue debugging |
| `<F1>` | Step Into |
| `<F2>` | Step Over |
| `<F3>` | Step Out |
| `<leader>b` | Toggle Breakpoint |
| `<leader>B` | Set a Conditional Breakpoint |
| `<F7>` | Toggle Debug UI (to see the last session result) |

## File Explorer (Neo-tree)
| Shortcut | Action |
|----------|--------|
| `\\` | Reveal Neo-tree (file tree explorer) |
| `d` | Delete file/folder under cursor |
| `a` | Add new file/folder (end with `/` for folder) |
| `r` | Rename file/folder |
| `c` | Copy file/folder |
| `m` | Move / Cut file/folder |
| `p` | Paste copied/moved file/folder |

## UI & Navigation Tools
| Shortcut | Action |
|----------|--------|
| `<C-\>` | Toggle floating terminal (`toggleterm.nvim`) |
| `<leader>a` | Harpoon: Add file to Harpoon list |
| `<C-e>` | Harpoon: Toggle Quick Menu |
| `<M-1>` | Go to Tab/Buffer 1 (Alt+1) |
| `<M-2>` | Go to Tab/Buffer 2 (Alt+2) |
| `<M-3>` | Go to Tab/Buffer 3 (Alt+3) |

## Eye Candy / Fun
| Shortcut | Action |
|----------|--------|
| `<leader>fml` | Cellular Automaton: "FML Code Rain" animation |
