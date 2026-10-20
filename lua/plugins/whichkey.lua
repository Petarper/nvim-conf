-- ============================================================================
-- which-key.nvim — popup showing available keymaps after the leader (or any
-- prefix). Purely discoverability; does not define new behaviour.
-- ============================================================================
local ok, wk = pcall(require, "which-key")
if not ok then
	return
end

wk.setup({
	preset = "modern",
	delay = 400, -- ms before the popup shows
	icons = { mappings = false }, -- avoid requiring extra icon config
})

-- Group labels for the leader prefixes used across the config.
wk.add({
	{ "<leader>f", group = "find / format" },
	{ "<leader>g", group = "git / goto" },
	{ "<leader>gh", group = "git diff" },
	{ "<leader>s", group = "split" },
	{ "<leader>t", group = "toggle" },
	{ "<leader>l", group = "lint / llama" },
	{ "<leader>ll", group = "llama" },
	{ "<localleader>l", group = "latex" },
})
