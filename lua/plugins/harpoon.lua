-- ============================================================================
-- Harpoon (harpoon2 API). Keymaps ported from old config and adapted:
--   old: mark.add_file / ui.toggle_quick_menu / ui.nav_file(n)
--   new: harpoon:list():add() / harpoon.ui:toggle_quick_menu() / :select(n)
-- ============================================================================
local ok, harpoon = pcall(require, "harpoon")
if not ok then
	return
end

harpoon:setup({})

local map = vim.keymap.set

map("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon add file" })

map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon quick menu" })

-- Ported nav slots (old: <C-n>/<C-m>/<C-,>/<C-.> -> files 1..4)
map("n", "<C-n>", function()
	harpoon:list():select(1)
end, { desc = "Harpoon file 1" })
map("n", "<C-m>", function()
	harpoon:list():select(2)
end, { desc = "Harpoon file 2" })
map("n", "<C-,>", function()
	harpoon:list():select(3)
end, { desc = "Harpoon file 3" })
map("n", "<C-.>", function()
	harpoon:list():select(4)
end, { desc = "Harpoon file 4" })

-- Harpoon highlights (ported)
vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
