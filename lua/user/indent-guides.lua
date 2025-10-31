
local highlight = {
    "First",
    -- "Second",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "First", { fg = "#316650" })
    -- vim.api.nvim_set_hl(0, "Second", { fg = "#595A68" })
end)

local opts = {
	scope = {
		enabled = true,
		highlight = highlight,
		show_start = false,
		show_end = false,
	},
	-- indent = {
	-- 	highlight = highlight,
	-- 	char = "│",
	-- },
}
require("ibl").setup(opts)
