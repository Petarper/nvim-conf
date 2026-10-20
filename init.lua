-- ============================================================================
-- Neovim configuration (native vim.pack)
-- Entry point: load order matters.
--   1. options  - editor defaults
--   2. keymaps  - all keybinds (ported verbatim from old config)
--   3. autocmds - autocommands
--   4. plugins  - vim.pack.add + per-plugin setup
-- ============================================================================

-- Leader must be set before any plugin/keymap that uses it.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("plugins")
