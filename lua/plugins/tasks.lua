-- ============================================================================
-- Compile / run / tasks.
--   overseer.nvim  - task runner (backend used by compiler.nvim)
--   compiler.nvim  - one-key compile/run for the current file/project
-- ============================================================================
local ov_ok, overseer = pcall(require, "overseer")
if ov_ok then
	overseer.setup({})
end

local comp_ok, compiler = pcall(require, "compiler")
if comp_ok then
	compiler.setup({})
end

local map = vim.keymap.set
-- compiler.nvim commands
map("n", "<leader>rc", "<cmd>CompilerOpen<CR>", { desc = "Compiler: open menu" })
map("n", "<leader>rr", "<cmd>CompilerStop<CR><cmd>CompilerRedo<CR>", { desc = "Compiler: redo last" })
map("n", "<leader>rt", "<cmd>CompilerToggleResults<CR>", { desc = "Compiler: toggle results" })
