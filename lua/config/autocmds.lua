-- ============================================================================
-- AUTOCOMMANDS (ported from old config)
-- The old format-on-save was tied to the `efm` LSP, which has been dropped.
-- It is adapted to format via any attached LSP that supports formatting.
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save (real file buffers only), via any formatting-capable LSP.
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	callback = function(args)
		local buf = args.buf
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[buf].buftype ~= "" then
			return
		end
		if not vim.bo[buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(buf) == "" then
			return
		end

		-- only format if at least one attached client supports it
		local can_format = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
			if c:supports_method("textDocument/formatting", buf) then
				can_format = true
				break
			end
		end
		if not can_format then
			return
		end

		pcall(vim.lsp.buf.format, { bufnr = buf, timeout_ms = 2000 })
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit", "tex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en", "hr" }
	end,
})

-- Terminal: no numbers/signcolumn, and auto-close on clean exit
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			pcall(vim.api.nvim_buf_delete, 0, {})
		end
	end,
})
