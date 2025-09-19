
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
vim.cmd [[hi statusline guifg=#BDB395]]
