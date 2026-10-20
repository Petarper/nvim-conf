-- ============================================================================
-- LSP + completion (ported from old lsp.lua; efm/efmls-configs removed)
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserLsp", { clear = true })

-- ---------------------------------------------------------------------------
-- Diagnostics UI
-- ---------------------------------------------------------------------------
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

-- Rounded borders for all LSP floating previews
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

-- ---------------------------------------------------------------------------
-- On-attach keymaps (ported verbatim)
-- ---------------------------------------------------------------------------
local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)
	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>fd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- ---------------------------------------------------------------------------
-- Completion: blink.cmp (ported config)
-- ---------------------------------------------------------------------------
local blink_ok, blink = pcall(require, "blink.cmp")
if blink_ok then
	blink.setup({
		keymap = {
			preset = "none",
			["<C-Space>"] = { "show", "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		appearance = { nerd_font_variant = "mono" },
		completion = { menu = { auto_show = true } },
		sources = { default = { "lsp", "path", "buffer", "snippets" } },
		snippets = {
			preset = "luasnip",
		},
		fuzzy = {
			implementation = "prefer_rust",
			prebuilt_binaries = { download = true },
		},
	})
end

-- ---------------------------------------------------------------------------
-- Mason + servers
-- ---------------------------------------------------------------------------
require("mason").setup({})

-- Map lspconfig server name -> Mason package name + optional prerequisite check.
-- Servers whose prerequisite tool is absent are skipped so Mason never nags
-- about an impossible install (e.g. gopls without the Go toolchain).
local server_specs = {
	lua_ls = { pkg = "lua-language-server" },
	pyright = { pkg = "pyright", prereq = "node" },
	bashls = { pkg = "bash-language-server", prereq = "node" },
	ts_ls = { pkg = "typescript-language-server", prereq = "node" },
	gopls = { pkg = "gopls", prereq = "go" },
	clangd = { pkg = "clangd" },
}

-- Decide which servers are viable on this machine.
local wanted = {}
for server, spec in pairs(server_specs) do
	if not spec.prereq or vim.fn.executable(spec.prereq) == 1 then
		table.insert(wanted, server)
	end
end

require("mason-lspconfig").setup({
	ensure_installed = wanted,
	automatic_installation = true,
})

-- Default capabilities (blink.cmp) for every server
if blink_ok then
	vim.lsp.config("*", {
		capabilities = blink.get_lsp_capabilities(),
	})
end

-- Server-specific overrides (ported)
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

-- Only enable servers that are actually installed in Mason, so a buffer never
-- triggers a start for a missing server.
local mason_ok, mason_registry = pcall(require, "mason-registry")
local to_enable = {}
for _, server in ipairs(wanted) do
	local pkg = server_specs[server].pkg
	local installed = true
	if mason_ok then
		local ok, p = pcall(mason_registry.get_package, pkg)
		installed = ok and p:is_installed()
	end
	if installed then
		table.insert(to_enable, server)
	end
end

vim.lsp.enable(to_enable)
