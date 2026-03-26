
--[[

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

local bn = require "better-n"

bn.setup(
  {
    -- These are default values, which can be omitted.
    -- By default, the following mappings are made repeatable using `n` and `<S-n>`:
    -- `f`, `F`, `t`, `T`, `*`, `#`, `/`, `?`
    disable_default_mappings = false,
    disable_cmdline_mappings = false,
  }
)

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "BetterNMappingExecuted",
--   callback = function(args)
--     -- args.data.repeatable_id and args.data.mode are available here
--   end
-- })

-- -------------------------------------------------------------------------------------------------
-- Block nav
local next_block = function()
	local keys = vim.api.nvim_replace_termcodes("<esc> in{", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end
local prev_block = function()
	local keys = vim.api.nvim_replace_termcodes("<esc> il{", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end
local block_nav = bn.create(
	{
		next = next_block,
		prev = prev_block,
	}
)
keymap({"n", "x", "v" }, "<A-b>", block_nav.next_key, opts)

-- -------------------------------------------------------------------------------------------------
-- Paren nav
local next_paren = function()
	local keys = vim.api.nvim_replace_termcodes("<esc> in(", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end
local prev_paren = function()
	local keys = vim.api.nvim_replace_termcodes("<esc> il(", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end
local paren_nav = bn.create(
	{
		next = next_paren,
		prev = prev_paren,
	}
)
keymap({"n", "x", "v" }, "<A-x>", paren_nav.next_key, opts)

]]
