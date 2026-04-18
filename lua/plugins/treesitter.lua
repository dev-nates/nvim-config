
local config = function()
	require('nvim-treesitter').setup {
		-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
		install_dir = vim.fn.stdpath('data') .. '/site'
	}

	require('nvim-treesitter').install { 'lua', 'c', 'c3', 'odin', 'markdown' }

	vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'lua', 'c', 'c3', 'odin' },
		callback = function()
			-- vim.treesitter.start()
			-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})

	vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	vim.wo[0][0].foldmethod = 'expr'
end

return {
}
--[[
return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = config,
	}
	-- { "nvim-treesitter/nvim-treesitter-context" },
}
]]
