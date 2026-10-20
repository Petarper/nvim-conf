-- ============================================================================
-- Habits & discovery.
--   hardtime.nvim     - breaks bad movement habits (nudges toward better motions)
--   precognition.nvim - shows available motions as virtual hints
--   helpview.nvim     - prettier :help rendering
-- ============================================================================

local ht_ok, hardtime = pcall(require, "hardtime")
if ht_ok then
	hardtime.setup({
		disable_mouse = false,
	})
end

local pc_ok, precognition = pcall(require, "precognition")
if pc_ok then
	precognition.setup({
		startVisible = false, -- toggle with the keymap below
	})
	vim.keymap.set("n", "<leader>tp", function()
		require("precognition").toggle()
	end, { desc = "Toggle precognition hints" })
end

-- helpview.nvim configures itself on load; guard the require so a missing
-- plugin never breaks startup.
pcall(require, "helpview")
