-- ============================================================================
-- VimTeX (ported from old config). Compile keymap <localleader>ll lives in
-- config/keymaps.lua. vimtex is a vimscript plugin configured via g: vars,
-- which must be set before the plugin loads its ftplugin for tex files.
-- ============================================================================

vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_version_check = 0

vim.g.vimtex_compiler_latexmk = {
	options = {
		"-shell-escape",
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
		"-lualatex", -- switches the engine
	},
}
