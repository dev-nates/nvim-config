
local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
	return
end

vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.opt.foldminlines = 0
vim.opt.fillchars = "fold: "


local function peek_folds()
	local window_id = ufo.peekFoldedLinesUnderCursor()
	if not window_id then
		vim.lsp.buf.hover()
	end
end


local keymap = vim.keymap.set
keymap("n", "zR", ufo.openAllFolds, { desc = "Open All Folds" })
keymap("n", "zM", ufo.closeAllFolds, { desc = "Close All Folds" })
keymap("n", "zK", peek_folds, { desc = "Peek Fold" })

local opts = {
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end
}
ufo.setup(opts)
