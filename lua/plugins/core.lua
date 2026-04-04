
return {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },

	-- Undo tree
	{ "mbbill/undotree" },

	-- More vim motions
	{ "wellle/targets.vim" },

	-- Align
	{
		"https://github.com/echasnovski/mini.align",
		config = function()
			require('mini.align').setup()
		end
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},
}
