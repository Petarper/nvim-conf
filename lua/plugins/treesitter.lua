-- ============================================================================
-- Treesitter (main-branch / rewrite API).
--
-- The main branch does NOT use `nvim-treesitter.configs`. Instead:
--   * parsers are installed via require('nvim-treesitter').install{...}
--   * highlighting is Neovim-native: vim.treesitter.start() per filetype
--   * folding/indent are enabled per-buffer via FileType autocmd
--
-- NOTE: installing parsers requires a C compiler (present: cc/gcc). Some
-- parsers additionally need `tree-sitter-cli` to be generated; install it via
-- your package manager (NOT npm) if `:TSInstall <lang>` complains.
-- ============================================================================
local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
	return
end

-- Ensure the tree-sitter CLI (installed to ~/.local/bin) is on nvim's PATH,
-- since the main branch shells out to `tree-sitter` to build parsers and the
-- launching shell (e.g. fish) may not export it.
do
	local local_bin = vim.fn.expand("~/.local/bin")
	if vim.fn.isdirectory(local_bin) == 1 and not string.find(vim.env.PATH or "", local_bin, 1, true) then
		vim.env.PATH = local_bin .. ":" .. (vim.env.PATH or "")
	end
end

ts.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

local ensure = {
	"lua",
	"vim",
	"vimdoc",
	"query",
	"bash",
	"python",
	"c",
	"cpp",
	"go",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"json",
	"yaml",
	"toml",
	"markdown",
	"markdown_inline",
	"latex",
	"bibtex",
}

-- Install missing parsers asynchronously (no-op for already-installed ones).
pcall(function()
	ts.install(ensure)
end)

-- Enable treesitter highlighting + folding/indent per filetype.
local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	callback = function(args)
		-- start() throws if no parser is available for this filetype; guard it.
		local started = pcall(vim.treesitter.start)
		if started then
			-- treesitter-based folding (expr set globally in options.lua)
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
			-- experimental treesitter indentation
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
