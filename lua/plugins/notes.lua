-- ============================================================================
-- Notes & markdown rendering.
--   obsidian.nvim        - work with an Obsidian vault (local, free app)
--   render-markdown.nvim - pretty in-buffer markdown rendering
--
-- Obsidian requires at least one workspace path. Adjust `vault` below to point
-- at your actual vault; the directory is created lazily by Obsidian itself.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- render-markdown.nvim
-- ---------------------------------------------------------------------------
local rm_ok, render_markdown = pcall(require, "render-markdown")
if rm_ok then
	render_markdown.setup({
		file_types = { "markdown" },
		completions = { lsp = { enabled = true } },
	})
end

-- ---------------------------------------------------------------------------
-- obsidian.nvim
-- ---------------------------------------------------------------------------
local vault = vim.fn.expand("~/notes")

-- Obsidian refuses to resolve a non-existent workspace path, so make sure the
-- vault directory exists before setup. Change `vault` above to your real vault.
if vim.fn.isdirectory(vault) == 0 then
	pcall(vim.fn.mkdir, vault, "p")
end

local obs_ok, obsidian = pcall(require, "obsidian")
if obs_ok then
	obsidian.setup({
		workspaces = {
			{
				name = "notes",
				path = vault,
			},
		},
		-- Let render-markdown.nvim handle the visual concealment instead of
		-- obsidian's weaker built-in UI.
		ui = { enable = false },
		completion = {
			nvim_cmp = false,
			blink = true,
			min_chars = 2,
		},
	})

	local map = vim.keymap.set
	map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "Obsidian: new note" })
	map("n", "<leader>oo", "<cmd>Obsidian quick_switch<CR>", { desc = "Obsidian: quick switch" })
	map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Obsidian: search" })
	map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Obsidian: backlinks" })
	map("n", "<leader>ot", "<cmd>Obsidian today<CR>", { desc = "Obsidian: today's daily note" })
end
