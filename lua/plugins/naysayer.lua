
local config = function()
	local colorscheme = "default"

	require('naysayer').setup({
		variant = 'main',
		dark_variant = 'main',
		bold_vert_split = false,
		dim_nc_background = false,
		disable_background = true,
		disable_float_background = true,
		disable_italics = true,
	})

	local ok, _ = pcall(vim.cmd, "colorscheme " .. "naysayer")
	if not ok then
		vim.notify("Failed to load colorscheme.")
		return
	end

	-- Set the status line to not be highlighted
	vim.cmd [[hi statusline guibg=#031C1F]]

	vim.cmd [[hi statusline guibg=none]]
	vim.cmd [[hi statusline guifg=#BDB395]]
	vim.cmd [[hi Normal ctermbg=none guibg=#031C1F]]

	-- vim.cmd [[hi @function guifg=#399578]]
	vim.cmd [[hi clear @property]]
	vim.cmd [[hi clear @type]]
	vim.cmd [[hi clear Type]]
	vim.cmd [[hi Type gui=bold]]

	vim.cmd [[hi @keyword.repeat gui=bold]]
	vim.cmd [[hi @keyword.return gui=bold]]
	vim.cmd [[hi @keyword.conditional gui=bold]]
	vim.cmd [[hi link @keyword.type @keyword.return]]

	vim.cmd [[hi @assert guifg=#b53d69]]
	vim.cmd [[hi @zero_struct guifg=#8c8677]]

	vim.cmd [[hi clear @variable.parameter]]


	local base = vim.api.nvim_get_hl(0, { name = "Keyword", link = false })
	base.bold = true
	-- base.fg = "#ff0000"  -- change what you want
	vim.api.nvim_set_hl(0, "@keyword.cast", base)

	base = vim.api.nvim_get_hl(0, { name = "Type", link = false })
	vim.api.nvim_set_hl(0, "@type.builtin", base)

	base = vim.api.nvim_get_hl(0, { name = "@function", link = false})
	base.bold = false
	vim.api.nvim_set_hl(0, "@nobold", base)

	-- vim.cmd [[hi link @type.builtin Type]]
end


return {
	-- Colorscheme
	{
		"alljokecake/naysayer-theme.nvim", as = 'naysayer',
		config = config,
	},
}
