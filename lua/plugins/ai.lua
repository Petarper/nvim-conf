-- ============================================================================
-- llama.vim — local, inline FIM (fill-in-the-middle) code completion.
--
-- IMPORTANT: llama.vim talks to a llama.cpp *server* (the `/infill` endpoint),
-- not to Ollama's API. You have `ollama` installed, but for llama.vim you need
-- a llama.cpp server running. One-time setup:
--
--   # install llama.cpp (provides `llama-server`), then run a FIM model:
--   llama-server --fim-qwen-3b-default      # <16GB VRAM
--   # or --fim-qwen-1.5b-default            # <8GB VRAM
--
-- The server listens on http://127.0.0.1:8012 by default, which matches the
-- endpoint below. If you prefer a pure-Ollama setup (no extra server), say so
-- and we can swap to an Ollama-native completion plugin.
--
-- Config must be set BEFORE the plugin loads its FIM logic; vim.pack adds the
-- plugin to runtimepath during plugins.lua, and this module runs right after,
-- so set g:llama_config here and the plugin reads it lazily on first insert.
-- ============================================================================

vim.g.llama_config = {
	-- llama.cpp server endpoint (default llama-server FIM port)
	endpoint_fim = "http://127.0.0.1:8012/infill",

	-- Suggest automatically while typing in insert mode
	auto_fim = true,

	-- Show the little inline perf/info hint
	show_info = 1,

	-- Context sizing (defaults are sensible; tweak for your hardware)
	n_prefix = 256,
	n_suffix = 64,
	n_predict = 128,

	-- Keymaps (Tab to accept full, Shift-Tab accept line — plugin defaults)
	keymap_fim_accept_full = "<Tab>",
	keymap_fim_accept_line = "<S-Tab>",
	keymap_fim_accept_word = "<leader>ll]",
	keymap_fim_trigger = "<leader>llf",

	-- Instruction-based editing
	keymap_inst_trigger = "<leader>lli",
}
