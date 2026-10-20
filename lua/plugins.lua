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
require("plugins.navigation")
require("plugins.harpoon")
require("plugins.oil")
require("plugins.ai")
require("plugins.notes")
require("plugins.tasks")
require("plugins.vimtex")
require("plugins.habits")
