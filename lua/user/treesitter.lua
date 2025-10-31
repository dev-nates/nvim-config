

local parsers = {
  "c", "odin", "lua", "luadoc", "bash", "nasm", "gitignore", "typescript", "css", "html", "json",
  "glsl", "hlsl", "tmux", "toml", "markdown", "yaml", "xml", "vimdoc",
}

local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = parsers,
  sync_install = false, 
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "odin" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false, disable = { "yaml" } },
}

-- Code folding

local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command('augroup '..group_name)
		api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
			api.nvim_command(command)

		end
		api.nvim_command('augroup END')
	end
end

local autoCommands = {
	-- other autocommands
	open_folds = {
		{"BufReadPost,FileReadPost", "*", "normal zR"}
	}
}
M.nvim_create_augroups(autoCommands)
