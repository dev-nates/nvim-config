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
keymap("n", "ze", peek_folds, { desc = "Peek Fold" })

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

local opts = {
	fold_virt_text_handler = handler,
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end
}
ufo.setup(opts)

-- vim.cmd [[hi UfoFoldedBg guibg=NONE]]
