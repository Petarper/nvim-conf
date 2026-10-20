-- ============================================================================
-- Formatting (conform.nvim) + Linting (nvim-lint) + tool install (mason).
--
-- Design notes (mirrors the prereq-aware pattern in lsp.lua):
--   * Each formatter/linter is a CLI tool installed via Mason.
--   * Tools whose prerequisite toolchain is missing are skipped so Mason never
--     tries an impossible install (e.g. goimports without the Go toolchain).
--   * Formatting: <leader>f (manual) + format-on-save (BufWritePre). Toggle
--     globally with <leader>tf.
--   * Linting: runs on BufEnter/BufWritePost/InsertLeave for configured
--     filetypes; results surface through vim.diagnostic (same UI as LSP).
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Prerequisite detection (same spirit as server_specs in lsp.lua)
-- ---------------------------------------------------------------------------
local function has(exe)
	return vim.fn.executable(exe) == 1
end

local has_node = has("node")
local has_go = has("go")
-- clang-format is installed via Mason (prebuilt binary, no system clang / sudo
-- needed), so C/C++ formatting is always available once Mason finishes.
local has_clang_tooling = true

-- ---------------------------------------------------------------------------
-- conform.nvim — formatters per filetype
-- ---------------------------------------------------------------------------
local conform_ok, conform = pcall(require, "conform")
if conform_ok then
	-- Build formatters_by_ft, gating prettier (needs node) / go tools / clang.
	local prettier = has_node and { "prettier" } or {}

	local formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format", "ruff_organize_imports" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		javascript = prettier,
		typescript = prettier,
		javascriptreact = prettier,
		typescriptreact = prettier,
		json = prettier,
		jsonc = prettier,
		yaml = prettier,
		css = prettier,
		scss = prettier,
		html = prettier,
		markdown = prettier,
	}

	if has_go then
		formatters_by_ft.go = { "goimports", "gofmt" }
	end
	if has_clang_tooling then
		formatters_by_ft.c = { "clang-format" }
		formatters_by_ft.cpp = { "clang-format" }
	end

	conform.setup({
		formatters_by_ft = formatters_by_ft,
		default_format_opts = { lsp_format = "fallback" },
		-- Format on save, unless globally disabled via <leader>tf.
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 1000, lsp_format = "fallback" }
		end,
	})

	-- Manual format (also works on a visual range).
	vim.keymap.set({ "n", "v" }, "<leader>f", function()
		conform.format({ async = true, lsp_format = "fallback" })
	end, { desc = "Format buffer/range" })

	-- Toggle format-on-save globally.
	vim.keymap.set("n", "<leader>tf", function()
		vim.g.disable_autoformat = not vim.g.disable_autoformat
		vim.notify("Format on save: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
	end, { desc = "Toggle format on save" })
end

-- ---------------------------------------------------------------------------
-- nvim-lint — linters per filetype (only those LSP doesn't already cover)
-- ---------------------------------------------------------------------------
local lint_ok, lint = pcall(require, "lint")
if lint_ok then
	local by_ft = {
		python = { "ruff" },
		sh = { "shellcheck" },
		bash = { "shellcheck" },
		markdown = { "markdownlint" },
	}

	-- eslint_d needs node; only register it when available.
	if has_node then
		local js = { "eslint_d" }
		by_ft.javascript = js
		by_ft.typescript = js
		by_ft.javascriptreact = js
		by_ft.typescriptreact = js
	end

	lint.linters_by_ft = by_ft

	local lint_group = vim.api.nvim_create_augroup("UserLint", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_group,
		callback = function()
			-- try_lint is a no-op for filetypes with no configured linter.
			lint.try_lint()
		end,
	})

	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
	end, { desc = "Lint buffer" })
end

-- ---------------------------------------------------------------------------
-- mason-tool-installer — ensure the CLI tools above are installed.
-- Gated by the same prereq checks so we never queue an impossible install.
-- ---------------------------------------------------------------------------
local mti_ok, mti = pcall(require, "mason-tool-installer")
if mti_ok then
	local ensure = {
		"stylua", -- lua formatter (via cargo/prebuilt)
		"ruff", -- python format + lint
		"shfmt", -- shell formatter
		"shellcheck", -- shell linter
		"markdownlint", -- markdown linter
	}

	if has_node then
		vim.list_extend(ensure, { "prettier", "eslint_d" })
	end
	if has_go then
		vim.list_extend(ensure, { "goimports" })
	end
	if has_clang_tooling then
		vim.list_extend(ensure, { "clang-format" })
	end

	mti.setup({
		ensure_installed = ensure,
		run_on_start = true,
		auto_update = false,
	})
end
