
local ls = require "luasnip"
local types = require "luasnip.util.types"
require('luasnip.loaders.from_vscode').lazy_load()

ls.cleanup()
ls.config.setup {}

-- -------------------------------------------------------------------------------------------------
-- Config
ls.config.set_config({
	history = false,
	update_events = "TextChanged,TextChangedI",

	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{ "<-" }},
			},
		},
	},
})

-- -------------------------------------------------------------------------------------------------
-- Luasnip keybindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap({"i", "s"}, "<C-n>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, opts)
keymap({"i", "s"}, "<C-p>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, opts)
keymap({"i", "s"}, "<C-t>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)
