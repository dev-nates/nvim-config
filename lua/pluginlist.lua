
return {
	-- Core
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ 'L3MON4D3/LuaSnip' },

	-- Telescope
	{ "nvim-telescope/telescope.nvim" },

	-- Tree
	{  "nvim-tree/nvim-tree.lua" },

	-- Undo Tree
	{ "mbbill/undotree" },

	-- Tree-Sitter
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		branch='master',
		build=':TSUpdate',
	},
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- Ufo Code Folding
  {
		"kevinhwang91/nvim-ufo", 
		dependencies = {"kevinhwang91/promise-async"},
	},

	-- Code completion
	{ "hrsh7th/nvim-cmp" },
	{ 'hrsh7th/cmp-buffer' },
	{ "saadparwaiz1/cmp_luasnip" },

  -- Harpoon (Thank you Sensei)
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	-- More vim motions
	{ "wellle/targets.vim" },

	-- Neovim comments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	},

	-- Align
	{
		"https://github.com/echasnovski/mini.align",
		config = function()
			require('mini.align').setup()
		end
	},

	-- Indent guides
  { "lukas-reineke/indent-blankline.nvim" },

	-- Comment box
	{ "LudoPinelli/comment-box.nvim" },

	-- Colorscheme
	{
		"alljokecake/naysayer-theme.nvim", as = 'naysayer',
	},
}
