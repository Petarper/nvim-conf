# Neovim Cheatsheet

> **Leader = `Space`** · **Localleader = `Space`**
> Keys shown as `<C-x>` = Ctrl+x, `<A-x>` = Alt+x, `<S-x>` = Shift+x.
> LSP keys (marked 🔌) only work when a language server is attached to the buffer.

---

## Daily essentials

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fuzzy, from cwd) |
| `<leader>fg` | Live grep (search text in project) |
| `<leader>fb` | Switch between open buffers |
| `<leader>e` or `-` | File explorer (oil — edit dir as a buffer) |
| `<leader>c` | Clear search highlights |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>bb` | Jump to the previously-edited buffer |
| `<C-c>` | Escape (in insert mode) |

---

## Finding things (fzf-lua)

| Key | Action |
|-----|--------|
| `<leader>ff` | Files from current working dir |
| `<leader>fo` | Files from the **current buffer's** dir |
| `<leader>fg` | Live grep across the project |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |
| `<leader>fx` | Diagnostics (current document) |
| `<leader>fX` | Diagnostics (whole workspace) |
| `<leader>fR` | Resume last picker |

---

## File explorer (oil)

| Key | Action |
|-----|--------|
| `-` | Open parent directory |
| `<leader>e` | Open file explorer |
| *(inside oil)* edit lines then `:w` | Create / rename / delete files as text |
| *(inside oil)* `-` | Go up a directory |

---

## Harpoon (quick file marks)

| Key | Action |
|-----|--------|
| `<leader>a` | Add current file to Harpoon |
| `<C-e>` | Toggle Harpoon quick menu |
| `<C-n>` | Jump to Harpoon file 1 |
| `<C-m>` | Jump to Harpoon file 2 |
| `<C-,>` | Jump to Harpoon file 3 |
| `<C-.>` | Jump to Harpoon file 4 |

---

## Windows & splits

| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<C-h/j/k/l>` | Move to left / down / up / right window |
| `<C-Up>` / `<C-Down>` | Grow / shrink height |
| `<C-Left>` / `<C-Right>` | Shrink / grow width |

---

## Movement & editing

| Key | Action |
|-----|--------|
| `j` / `k` | Down / up (wrap-aware — moves by screen line) |
| `gh` / `gl` | Start / end of line |
| `<C-d>` / `<C-u>` | Half-page down / up (stays centered) |
| `n` / `N` | Next / prev search result (centered) |
| `<A-j>` / `<A-k>` | Move line (or selection) down / up |
| `<A-a>` | Select all |
| `J` | Join lines (keeps cursor in place) |
| `<` / `>` (visual) | Indent left / right and keep selection |
| `<leader>p` (visual) | Paste over selection **without** yanking it |
| `<leader>x` | Delete **without** yanking (black-hole) |
| `<leader>pa` | Copy full file path to clipboard |

---

## LSP — code intelligence 🔌

| Key | Action |
|-----|--------|
| `K` | Hover docs |
| `<leader>gd` | Go to definition (fuzzy picker) |
| `<leader>gD` | Go to definition (direct jump) |
| `<leader>gS` | Go to definition in a vertical split |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>oi` | Organize imports + format |
| `<leader>fr` | References (fuzzy) |
| `<leader>fd` | Definitions (fuzzy) |
| `<leader>ft` | Type definitions |
| `<leader>fi` | Implementations |
| `<leader>fs` | Document symbols |
| `<leader>fw` | Workspace symbols |

### Diagnostics

| Key | Action |
|-----|--------|
| `<leader>d` | Show diagnostic under cursor |
| `<leader>D` | Show all diagnostics on the line |
| `<leader>nd` / `<leader>pd` | Next / previous diagnostic |
| `<leader>dl` | Show line diagnostics (float) |
| `<leader>q` | Open diagnostics in the location list |
| `<leader>td` | Toggle diagnostics on/off |

> **Format on save** happens automatically for any file whose LSP supports it.

---

## Completion (blink.cmp — in insert mode)

| Key | Action |
|-----|--------|
| `<C-Space>` | Show / hide completion menu |
| `<C-j>` / `<C-k>` | Next / previous item |
| `<CR>` | Accept selected item |
| `<Tab>` / `<S-Tab>` | Jump forward / back through snippet fields |

---

## AI inline completion (llama.vim — insert mode)

> Needs a local `llama-server` running on port 8012. See `lua/plugins/ai.lua`.

| Key | Action |
|-----|--------|
| `<Tab>` | Accept the full suggestion |
| `<S-Tab>` | Accept the first line |
| `<leader>ll]` | Accept the next word |
| `<leader>llf` | Manually trigger a suggestion |
| `<leader>lli` | Instruction-based edit |

---

## Notes & markdown (obsidian)

> Vault lives at `~/notes` (change in `lua/plugins/notes.lua`).

| Key | Action |
|-----|--------|
| `<leader>on` | New note |
| `<leader>oo` | Quick switch between notes |
| `<leader>os` | Search notes |
| `<leader>ob` | Show backlinks |
| `<leader>ot` | Open today's daily note |

---

## Compile / run (compiler.nvim)

| Key | Action |
|-----|--------|
| `<leader>rc` | Open compiler menu |
| `<leader>rr` | Redo last compile |
| `<leader>rt` | Toggle results window |

---

## LaTeX (vimtex)

| Key | Action |
|-----|--------|
| `<localleader>ll` | Compile the document |

---

## Habits / discovery

| Key | Action |
|-----|--------|
| `<leader>tp` | Toggle precognition motion hints |

> **hardtime.nvim** is active — it nudges you away from spamming `h/j/k/l` and arrow keys toward more efficient motions.

---

## Handy built-ins (no custom map)

| Key | Action |
|-----|--------|
| `za` | Toggle fold under cursor |
| `zR` / `zM` | Open / close all folds |
| `gcc` / `gc` (visual) | *(if you add a comment plugin later)* |
| `:Mason` | Manage LSP servers / tools |
| `:checkhealth` | Diagnose config/plugin issues |
| `:Pack` / `:lua vim.pack.update()` | Update plugins (native vim.pack) |
