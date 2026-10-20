-- ============================================================================
-- PLUGINS (native vim.pack)
-- Declare everything up front, then require per-plugin setup modules.
-- Plugins installed by vim.pack are added to the runtimepath automatically,
-- so no manual :packadd is needed for `start` plugins.
-- ============================================================================

vim.pack.add({
	-- Dependencies / libraries
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	-- LSP + completion
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },

	-- Formatting / linting / tool install
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- Treesitter (uses the current default `main` branch / rewrite API).
	-- Highlight/indent/fold are enabled per-filetype in the config module.
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	-- Navigation / files (no tree)
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/stevearc/oil.nvim" },

	-- UI
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/neanias/everforest-nvim" },

	-- Editing ergonomics
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/echasnovski/mini.surround" },
	{ src = "https://github.com/echasnovski/mini.ai" },

	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	-- Discoverability
	{ src = "https://github.com/folke/which-key.nvim" },

	-- Motion (on trial — safe to remove; see lua/plugins/flash.lua)
	{ src = "https://github.com/folke/flash.nvim" },

	-- AI (local, inline FIM)
	{ src = "https://github.com/ggml-org/llama.vim" },

	-- Notes / markdown
	{ src = "https://github.com/epwalsh/obsidian.nvim", version = vim.version.range("3.*") },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

	-- Compile / run / tasks
	{ src = "https://github.com/stevearc/overseer.nvim" },
	{ src = "https://github.com/Zeioth/compiler.nvim" },

	-- LaTeX
	{ src = "https://github.com/lervag/vimtex" },

	-- Habits / discovery / help
	{ src = "https://github.com/m4xshen/hardtime.nvim" },
	{ src = "https://github.com/tris203/precognition.nvim" },
	{ src = "https://github.com/OXY2DEV/helpview.nvim" },
})

-- Per-plugin setup (order matters: colorscheme/ui early, lsp after cmp).
require("plugins.colorscheme")
require("plugins.ui")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.formatting")
require("plugins.navigation")
require("plugins.harpoon")
require("plugins.oil")
require("plugins.ai")
require("plugins.notes")
require("plugins.tasks")
require("plugins.vimtex")
require("plugins.habits")
require("plugins.editing")
require("plugins.git")
require("plugins.whichkey")
require("plugins.flash")
