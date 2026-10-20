-- ============================================================================
-- flash.nvim — fast cursor jumping via labeled targets.
-- NOTE: this is on trial; to remove, delete this file, drop the require in
-- plugins.lua, and remove the flash.nvim entry from the vim.pack.add list.
--
-- Keymaps:
--   s        (n/x/o) — flash jump
--   S        (n/x/o) — flash treesitter (select by syntax node)
--   r        (o)     — remote flash (operate at a distance)
--   R        (o/x)   — treesitter search
--   <C-s>    (c)     — toggle flash while searching
--
-- Heads-up: `s` normally = "substitute char". mini.surround uses `s`-prefixed
-- mappings (sa/sd/sr...) but those are multi-key, so a bare `s` jump coexists.
-- If you miss native `s`, use `cl`. Easy to rebind below.
-- ============================================================================
local ok, flash = pcall(require, "flash")
if not ok then
	return
end

flash.setup({})

local map = vim.keymap.set
map({ "n", "x", "o" }, "s", function()
	flash.jump()
end, { desc = "Flash jump" })
map({ "n", "x", "o" }, "S", function()
	flash.treesitter()
end, { desc = "Flash treesitter" })
map("o", "r", function()
	flash.remote()
end, { desc = "Remote flash" })
map({ "o", "x" }, "R", function()
	flash.treesitter_search()
end, { desc = "Treesitter search" })
map("c", "<C-s>", function()
	flash.toggle()
end, { desc = "Toggle flash search" })
