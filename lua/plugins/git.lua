-- ============================================================================
-- gitsigns.nvim — git diff signs in the gutter + hunk ops + inline blame.
-- Keymaps grouped under <leader>g* (git) and ]c/[c for hunk navigation.
-- ============================================================================
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
	return
end

gitsigns.setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	current_line_blame = false, -- toggle with <leader>gb
	current_line_blame_opts = { delay = 300, virt_text_pos = "eol" },
	on_attach = function(bufnr)
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Hunk navigation (works with diff mode too).
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, "Next git hunk")
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, "Prev git hunk")

		-- Hunk actions.
		map("n", "<leader>gs", gitsigns.stage_hunk, "Stage hunk")
		map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")
		map("v", "<leader>gs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage selected hunk")
		map("v", "<leader>gr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset selected hunk")
		map("n", "<leader>gS", gitsigns.stage_buffer, "Stage buffer")
		map("n", "<leader>gR", gitsigns.reset_buffer, "Reset buffer")
		map("n", "<leader>gu", gitsigns.undo_stage_hunk, "Undo stage hunk")
		map("n", "<leader>gp", gitsigns.preview_hunk, "Preview hunk")

		-- Blame.
		map("n", "<leader>gB", function()
			gitsigns.blame_line({ full = true })
		end, "Blame line (full)")
		map("n", "<leader>gb", gitsigns.toggle_current_line_blame, "Toggle line blame")

		-- Diff. (<leader>gd/gD are used by LSP for definitions; use gh* here.)
		map("n", "<leader>ghd", gitsigns.diffthis, "Diff this")
		map("n", "<leader>ghD", function()
			gitsigns.diffthis("~")
		end, "Diff this (against ~)")
	end,
})
