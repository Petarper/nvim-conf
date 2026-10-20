-- Everforest colorscheme — soft + dark combo
local ok, everforest = pcall(require, "everforest")
if not ok then
	return
end

everforest.setup({
	background = "soft", -- "hard" | "medium" | "soft"
	transparent_background_level = 0,
	italics = true,
	disable_italic_comments = false,
})

vim.o.background = "dark"
vim.cmd.colorscheme("everforest")
