-- ============================================================================
-- fzf-lua — primary navigation (no file tree).
-- `<leader>ff` opens files from the current working dir; combined with oil for
-- buffer-style file ops this replaces a persistent sidebar tree.
-- ============================================================================
local ok, fzf = pcall(require, "fzf-lua")
if not ok then
	return
end

fzf.setup({
	winopts = {
		height = 0.85,
		width = 0.85,
		preview = { layout = "vertical", vertical = "down:45%" },
	},
})

-- Use fzf-lua for vim.ui.select menus
fzf.register_ui_select()

local map = vim.keymap.set

-- Ported file/grep/buffer/help pickers
map("n", "<leader>ff", fzf.files, { desc = "FZF Files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "FZF Live Grep" })
map("n", "<leader>fb", fzf.buffers, { desc = "FZF Buffers" })
map("n", "<leader>fh", fzf.help_tags, { desc = "FZF Help Tags" })
map("n", "<leader>fx", fzf.diagnostics_document, { desc = "FZF Diagnostics Document" })
map("n", "<leader>fX", fzf.diagnostics_workspace, { desc = "FZF Diagnostics Workspace" })

-- "Move with me" extras: files relative to the current buffer's directory
map("n", "<leader>fo", function()
	fzf.files({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "FZF Files (current buffer dir)" })
map("n", "<leader>fR", fzf.resume, { desc = "FZF Resume last picker" })
