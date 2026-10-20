-- ============================================================================
-- oil.nvim — edit the filesystem like a buffer (no persistent sidebar tree).
-- Open the parent dir of the current file with `-`, then edit/rename/delete
-- lines as text and `:w` to apply.
-- ============================================================================
local ok, oil = pcall(require, "oil")
if not ok then
	return
end

oil.setup({
	default_file_explorer = true, -- hijack netrw
	columns = { "icon" },
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["<C-h>"] = false, -- keep window-left navigation
		["<C-l>"] = false, -- keep window-right navigation
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory (oil)" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer (oil)" })
