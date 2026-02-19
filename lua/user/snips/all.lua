
local ls = require "luasnip"
local procs = require "user.snips.procs"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- -------------------------------------------------------------------------------------------------
-- #all
ls.add_snippets('all', {
	s('curtime',
		f(function()
			return os.date "%D -- %H:%M"
		end)
	),
	s('todo', t "@Todo:"),
	s("note", t "@Note:"),
})

