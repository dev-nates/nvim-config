local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  -- use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  -- Completion
  --use "hrsh7th/nvim-cmp"
  --use 'L3MON4D3/LuaSnip'

  --use 'hrsh7th/cmp-buffer'
  --use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-cmdline'
  -- use "saadparwaiz1/cmp_luasnip" -- snippet completions
  -- use "hrsh7th/cmp-nvim-lsp"
  -- use "hrsh7th/cmp-nvim-lua"


  -- LSP
  -- use "neovim/nvim-lspconfig" -- enable LSP
  -- use "williamboman/mason.nvim" -- simple to use language server installer
  -- use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  -- use "jose-elias-alvarez/null-ls.nvim" -- LSP diagnostics and code actions

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  -- use "nvim-telescope/telescope-media-files.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }


  -- Harpoon (Thank you Sensei)
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }

  -- Nvim Tree
  use "nvim-tree/nvim-tree.lua"
  use "nvim-tree/nvim-web-devicons"

  -- Undo Tree
  use "mbbill/undotree"

  -- UFO Code folding
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  use {
	  "windwp/nvim-autopairs",
	  event = "InsertEnter",
	  config = function()
		  require("nvim-autopairs").setup ({
			  enabled = function(bufnr) return true end, -- control if auto-pairs should be enabled when attaching to a buffer
			  disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
			  disable_in_macro = true, -- disable when recording or executing a macro
			  disable_in_visualblock = false, -- disable when insert after visual block mode
			  disable_in_replace_mode = true,
			  ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
			  enable_moveright = true,
			  enable_afterquote = true, -- add bracket pairs after quote
			  enable_check_bracket_line = true, --- check bracket in same line
			  enable_bracket_in_quote = true, --
			  enable_abbr = false, -- trigger abbreviation
			  break_undo = true, -- switch for basic rule break undo sequence
			  check_ts = false,
			  map_cr = true,
			  map_bs = true, -- map the <BS> key
			  map_c_h = true, -- Map the <C-h> key to delete a pair
			  map_c_w = true, -- map <c-w> to delete a pair if possible
		  })
	  end
  }

  -- Comments
  use {
	  'numToStr/Comment.nvim',
	  config = function()
		  require('Comment').setup()
	  end
  }

  -- Comment Box
  use "LudoPinelli/comment-box.nvim"

  -- Colorscheme
  use ({'alljokecake/naysayer-theme.nvim', as = 'naysayer'})

  --[[
  use { 
	  'olivercederborg/poimandres.nvim',
	  config = function()
		  require('poimandres').setup {
			  -- leave this setup function empty for default config
			  -- or refer to the configuration section
			  -- for configuration options
		  }
	  end
  }
  ]]

  -- Indent guides
  use { 'lukas-reineke/indent-blankline.nvim' }

  -- Align
  use { 'https://github.com/echasnovski/mini.align'	}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
	  require("packer").sync()
  end
end)
