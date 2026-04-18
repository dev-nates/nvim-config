
local c_colors = function()
	vim.cmd [[hi cAssert guifg=#b53d69]]
	vim.cmd [[hi cZeroStruct guifg=#8c8677]]
	-- vim.cmd [[hi cString guifg=#3FB186]]
end

local c3_colors = function()
	vim.cmd [[hi c3Assert guifg=#b53d69]]
end

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

	vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'c' },
		callback = function() c_colors() end,
	})
	vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'c3' },
		callback = function() c3_colors() end,
	})
end


return {
	-- Colorscheme
	{
		"alljokecake/naysayer-theme.nvim", as = 'naysayer',
		config = config,
	},
}
