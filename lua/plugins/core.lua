
return {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },

	-- Undo tree
	{ "mbbill/undotree" },

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
