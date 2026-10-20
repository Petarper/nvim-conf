-- ============================================================================
-- Editing ergonomics:
--   * nvim-autopairs  — auto-close (){}[]""'' and friends.
--   * mini.surround   — add/delete/replace surrounding pairs.
--   * mini.ai         — enhanced a/i text objects (functions, args, brackets
--                       with next/last, treesitter-aware).
-- ============================================================================

-- ---------------------------------------------------------------------------
-- nvim-autopairs (integrates with blink.cmp automatically via its own hooks)
-- ---------------------------------------------------------------------------
local ap_ok, autopairs = pcall(require, "nvim-autopairs")
if ap_ok then
	autopairs.setup({
		check_ts = true, -- use treesitter to avoid pairing in strings/comments
		fast_wrap = {}, -- enable Alt-e fast-wrap with defaults
	})
end

-- ---------------------------------------------------------------------------
-- mini.surround
--   Defaults (non-conflicting with vim motions):
--     sa = add, sd = delete, sr = replace, sf/sF = find, sh = highlight.
-- ---------------------------------------------------------------------------
local surr_ok, surround = pcall(require, "mini.surround")
if surr_ok then
	surround.setup({
		mappings = {
			add = "sa",
			delete = "sd",
			find = "sf",
			find_left = "sF",
			highlight = "sh",
			replace = "sr",
			update_n_lines = "sn",
		},
	})
end

-- ---------------------------------------------------------------------------
-- mini.ai — better a/i text objects.
--   Adds, among others:
--     af/if = function call   (treesitter: whole/inner function)
--     aa/ia = argument
--     a?/i? = user-prompted    and next/last variants via a/i + n/l.
-- ---------------------------------------------------------------------------
local ai_ok, miniai = pcall(require, "mini.ai")
if ai_ok then
	local gen = miniai.gen_spec
	miniai.setup({
		n_lines = 500,
		custom_textobjects = {
			-- Treesitter-based function and class objects (requires parsers,
			-- which treesitter.lua already installs for your languages).
			f = gen.treesitter({ a = "@function.outer", i = "@function.inner" }),
			c = gen.treesitter({ a = "@class.outer", i = "@class.inner" }),
			-- Function argument object.
			a = gen.argument(),
		},
	})
end
