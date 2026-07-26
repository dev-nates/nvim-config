

local sethl = vim.api.nvim_set_hl
local inspect = vim.inspect

local apply = function()
	vim.cmd("highlight clear")

	local background = '#062625'
	local background_pop = '#0a3836'
	local background_pop_subtle = '#062b2a'

	local normal_text = '#d1b897'
	local lighter_text = '#e2bd8c'
	local darker_text = '#847c72'
	local accent = '#41c67b'
	local pop = '#c67b41'
	local comment = '#53d549'
	local darker_comment = '#61875e'
	local constant = '#5cc9ba'

	local note='#487cd6'
	local warning='#fcb24b'
	local todo='#cc4576'
	local important='#ffffff'

	-- ------------------------------------------------------------
	-- Group: 'highlight group name' && 'color table'
	local groups = {
		{ 'Normal',       { fg = normal_text, bg = background } },
		{ 'Operator',     { fg = darker_text } },
		{ 'Delimiter',    { fg = darker_text } },
		{ 'Special',      { fg = darker_text } },
		{ 'Function',     { fg = accent      } },
		{ 'Identifier',   { fg = lighter_text, bold = true   } },
		{ 'Comment',      { fg = comment        } },
		{ 'DisabledCode', { fg = darker_comment } },
		{ 'Constant',     { fg = constant       } },
		{ 'String',       { fg = constant       } },
		-- { 'Statement',    {                     } },


		{ 'SnacksIndent',      { fg = background_pop, blend = 10 } },
		{ 'SnacksIndentScope', { fg = darker_text, blend = 10 } },
		{ '@variable',         { fg = normal_text } },

		{ 'StatusLine', { fg = accent, bg = background_pop }},
		{ 'MsgArea', { fg = accent, bg = background_pop }},
		{ 'Search', { fg = pop, bg = background }},
		{ 'CurSearch', { fg = accent, bg = background_pop }},
		{ 'QuickFixLine', { fg = accent, bg = background_pop }},
		{ 'CursorLine', { bg = background_pop_subtle }},

		{ 'CommentNote', { fg = note }},
		{ 'CommentWarning', { fg = warning }},
		{ 'CommentTodo', { fg = todo }},
		{ 'CommentImportant', { fg = important }},
	}

	for k,t in ipairs(groups) do
		sethl(0, t[1], t[2])
	end
end

local Colorscheme = {
	apply = apply,
}
return Colorscheme
