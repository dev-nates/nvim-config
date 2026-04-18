
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

-- Remove some default mappings that conflict with targets
vim.keymap.del({ "o", "x" }, "in")
vim.keymap.del({ "o", "x" }, "an")

keymap({"o"}, "n", "ina", opts)
keymap({"o"}, "l", "ila", opts)

return {
	-- More vim motions
	{ "wellle/targets.vim" },
}
