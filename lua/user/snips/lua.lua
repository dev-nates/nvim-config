
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

-- local same = function(index)
-- 	return f(function(args)
-- 		return args[1]
-- 	end, {index})
-- end

-- local get_test_result = function(position)
-- 	return d(position, function()
-- 		local nodes = {}
-- 		table.insert(nodes, t "")
-- 		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
-- 		for _, line in ipairs(lines) do
-- 			if line:match("-- test") then
-- 				table.insert(nodes, fmt([[ -> Result({}) ]], {i(1)}))
-- 				break
-- 			end
-- 		end
-- 		return sn(nil, c(1, nodes))
-- 	end)
-- end


-- -------------------------------------------------------------------------------------------------
-- #lua
ls.add_snippets("lua", {
	s("req",
		fmt([[local {} = require "{}"]], { f(function(import_name)
			local parts = vim.split(import_name[1][1], ".", true)
			return parts[#parts] or ""
		end, {1}), i(1) })
	),
})

