
local ls = require "luasnip"
local procs = require "user.snips.procs"

local keymap = vim.keymap.set
keymap("n", "<leader>l", "<cmd>source ~/.config/nvim/lua/user/snips/odin.lua<cr>")

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

function trim_surrounding_whitespace(s)
   return s:match( "^%s*(.-)%s*$" )
end

local value_list_last_item = function(value_list)
	local parts = vim.split(value_list, ",", true)
	return trim_surrounding_whitespace(parts[#parts]) or ""
end

local check_for_vulkan = function()
	return f(function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, 100, false)
		for _, line in ipairs(lines) do
			if string.find(line, "gfx/vk") ~= nil then
				return " vk."
			end
		end
		return " "
	end)
end


-- Map of default values for types
local default_values = {
	int = "0", i8 = "0", i16 = "0", i32 = "0", i64 = "0",
	uint = "0", u8 = "0", u16 = "0", u32 = "0", u64 = "0",
	f32 = "0.0", f64 = "0.0",

	bool = "false", b8 = "false", b16 = "false", b32 = "false", b64 = "false",
	string = '""',

	[function(text)
		return string.find(text, "^", 1, true) ~= nil
	end] = function(_, _)
		return t "nil"
	end,

	[function(text)
		return not string.find(text, "^", 1, true) and string.upper(string.sub(text, 1, 1)) == string.sub(text, 1, 1)
	end] = function(text, info)
		return c(info.index, {
			t("{}"),
			t(text .. "{}"),
		})
	end
}


-- Transforms some text into a snippet node
-- @param text string
-- @param info table
local transform = function(text, info)
	-- Determines whether the key matches the condition
	local condition_matches = function(condition, ...)
		if type(condition) == "string" then
			return condition == text
		else
			return condition(...)
		end
	end

	for condition, result in pairs(default_values) do
		if condition_matches(condition, text, info) then
			if type(result) == "string" then
				return t(result)
			else
				return result(text, info)
			end
		end
	end

	-- If no matches found, return the text
	return t(text)
end

local handle_type_node = function(type_node,  info)
		local result = {}

		local node = type_node:named_child(0)
		if node == nil then return result end

		local type = node:type()
		if type == "tuple_type" then
			local count = node:named_child_count()
			for idx = 0, count - 1 do
				local child = node:named_child(idx)
				if child:type() == "named_type" then
					child = child:named_child(1)
				elseif child:type() ~= "type" then
					goto continue
				end

				local text = vim.treesitter.get_node_text(child:named_child(0), 0)
				table.insert(result, transform(text, info))
				if idx ~= count - 1 then
					table.insert(result, t { ", " })
				end
				::continue::
			end
		elseif type == "identifier" then
			local text = vim.treesitter.get_node_text(node, 0)
			table.insert(result, transform(text, info))
		end

		return result
end

local odin_result_type = function(info)
	local procedure_node_types = {
		procedure = true,
		procedure_type = true,
	}

	-- Find the first function that's a parent of the cursor
	local node = vim.treesitter.get_node()
	while node ~= nil do
		if procedure_node_types[node:type()] then
			break
		end
		node = node:parent()
	end
	if not node then
		vim.notify "not inside of a procedure"
		return t ""
	end

	local count = node:named_child_count()
	local type_node = nil
	for idx = 0, count - 1 do
		local child = node:named_child(idx)
		if child:type() == "type" then
			type_node = child
			break
		end
	end
	if type_node == nil then return {} end

	return handle_type_node(type_node, info)

	-- local query = assert(vim.treesitter.query.get("odin", "return-snippet"), "no query")
	-- for _, capture in query:iter_captures(node, 0) do
	-- 	if handlers[capture:type()] then
	-- 		return handlers[capture:type()](capture, info)
	-- 	end
	-- end
	--
end

local odin_return_values = function(args)
	return sn(nil, odin_result_type({ index = 1, err_name = value_list_last_item(args[1][1]), proc_name = args[2][1] }))
end

-- -------------------------------------------------------------------------------------------------
-- #snippets
ls.add_snippets("odin", {
	-- -------------------------------------------------------------------------------------------------
	-- #general
	s("imp",
		fmta([[import <prefix>"<path>"]], {prefix = i(0), path = i(1)})
	),

	s("proc",
	fmta(
		[[
		<name> :: proc(<args>) <ret>{
			<body>
		}
		]], { name=i(1), args=i(2), ret=i(3), body=i(0) }
	)
	),

	s("struct",
		fmta(
			[[
			<name> :: struct {
				<body>
			}
			]], {name=i(1), body=i(0)}
		)
	),

	s("union",
		fmta(
			[[
			<name> :: union {
				<body>
			}
			]], {name=i(1), body=i(0)}
		)
	),

	s("structn",
		fmta(
			[[
			<name> :: struct {
				<next>: ^<name0>,
				<body>
			}
			]], {name=i(1), next=i(2), name0=rep(1), body=i(0) }
		)
	),

	s("enum",
		fmta(
			[[
			<name> :: enum {
				<body>
			}
			]], {name=i(1), body=i(0)}
		)
	),

	s("fori",
		fmta(
			[[
			for <i> := <val>; <cond>; <i0> += 1 {
				<body>
			}
			]], {i=i(1, "i"), val=i(2, "0"), cond=i(3), i0=rep(1), body=i(0)}
		)
	),

	s("forn",
		fmta(
			[[
			for <node> := <val>; <node0> != nil; <node1> = <node2>.<next> {
				<body>
			}
			]], {node=i(1), val=i(2), node0=rep(1), node1=rep(1), node2=rep(1), next=i(3, "next"), body=i(0)}
		)
	),

	s("forcn",
		fmta(
			[[
			for <node> := <val>; !base.chknil(<node0>, <nilv>); <node1> = <node2>.<next> {
				<body>
			}
			]], {node=i(1, "node"), val=i(2), node0=rep(1), nilv=i(3, "nil"), node1=rep(1), node2=rep(1), next=i(4, "next"), body=i(0)}
		)
	),

	s("switch",
		fmta(
			[[
			switch (<var>) {
				<body>
			}
			]], {var=i(1), body=i(0)}
		)
	),

	-- -------------------------------------------------------------------------------------------------
	-- #arena
	s("ps",
		c(1, {
			fmta(
				[[
				<var> := mem.push_struct(<type>, <arena>)
				]], {var=i(1), type=i(2, "type"), arena=i(3, "arena")}
			),
			fmta(
				[[
				<var> = mem.push_struct(<type>, <arena>)
				]], {var=i(1), type=i(2, "type"), arena=i(3, "arena")}
			)
		})
	),
	s("psn",
		c(1, {
			fmta(
				[[
				<var> := mem.push_struct_no_zero(<type>, <arena>)
				]], {var=i(1), type=i(2, "type"), arena=i(3, "arena")}
			),
			fmta(
				[[
				<var> = mem.push_struct_no_zero(<type>, <arena>)
				]], {var=i(1), type=i(2, "type"), arena=i(3, "arena")}
			)
		})
	),

	s("pa",
		c(1, {
			fmta(
				[[
				<var> := mem.push_array(<type>, <count>, <arena>)
				]], {var=i(1), type=i(2, "type"), count=i(3, "count"), arena=i(4, "arena")}
			),
			fmta(
				[[
				<var> = mem.push_array(<type>, <count>, <arena>)
				]], {var=i(1), type=i(2, "type"), count=i(3, "count"), arena=i(4, "arena")}
			)
		})
	),
	s("pan",
		c(1, {
			fmta(
				[[
				<var> := mem.push_array_no_zero(<type>, <count>, <arena>)
				]], {var=i(1), type=i(2, "type"), count=i(3, "count"), arena=i(4, "arena")}
			),
			fmta(
				[[
				<var> = mem.push_array_no_zero(<type>, <count>, <arena>)
				]], {var=i(1), type=i(2, "type"), count=i(3, "count"), arena=i(4, "arena")}
			)
		})
	),

	-- -------------------------------------------------------------------------------------------------
	-- #stack
	
	s("stkpush",
		fmta(
			[[
			<node>.<next> = <head>; <head0> = <node0>
			]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1)}
		)
	),

	s("stkpushc",
		fmta(
			[[
			<node>.<next> = <head>; <head0> = <node0>
			<count> += 1
			]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1), count=i(4, "count")}
		)
	),

	s("stkpop",
		fmta(
			[[
			<head> = <head0>.<next>
			]], {head=i(1, "head"), head0=rep(1), next=i(2, "next") }
		)
	),

	s("stkpopc",
		fmta(
			[[
			<head> = <head0>.<next>
			<count> -= 1
			]], {head=i(1, "head"), head0=rep(1), next=i(2,"next"), count=i(3, "count")}
		)
	),

	s("flpush",
		fmta(
			[[
			<node>.<next> = <freelist>; <freelist0> = <node0>
			sanitizer.address_poison(<node1>)
			]], {node=i(1, "node"), next=i(2, "next"), freelist=i(3, "freelist"), freelist0=rep(3), node0=rep(1), node1=rep(1)}
		)
	),

	s("flpop",
		c(1, {
			fmta(
				[[
				<assign>
				sanitizer.address_unpoison(<assign0>)
				<freelist> = <freelist0>.next
				]], {assign=i(1, "node := freelist"),
				assign0=f(function(assign)
					local parts = vim.split(assign[1][1], " ", true)
					return parts[1]
				end, {1}),
				freelist=i(2, "freelist"), freelist0=rep(2)}
			),
			fmta(
				[[
				sanitizer.address_unpoison(<node>)
				<freelist> = <freelist0>.next
				]], { node=i(1), freelist=i(2, "freelist"), freelist0=rep(2)}
			),
		})
	),

	s("flpopc",
		c(1, {
			fmta(
				[[
				<assign>
				sanitizer.address_unpoison(<assign0>)
				<freelist> = <freelist0>.next
				<count> -= 1
				]], {assign=i(1, "node := freelist"),
				assign0=f(function(assign)
					local parts = vim.split(assign[1][1], " ", true)
					return parts[1]
				end, {1}),
				freelist=i(2, "freelist"), freelist0=rep(2), count=i(3, "count")}
			),
			fmta(
				[[
				sanitizer.address_unpoison(<node>)
				<freelist> = <freelist0>.next
				<count> -= 1
				]], { node=i(1), freelist=i(2, "freelist"), freelist0=rep(2), count=i(3, "count")}
			),
		})
	),

	-- -------------------------------------------------------------------------------------------------
	-- #linked list
	
	s("ptr",
		fmt(
			[[
			{} := ({} == nil) ? &{} : &{}.{}
			]], {i(1, "ptr"), i(2, "head"), rep(2), i(3, "tail"), i(4, "next") }
		)
	),
	s("ptrnext",
		fmta(
			[[
			<ptr> = <node>.<next>
			]], {ptr=i(1, "ptr"), node=i(2, "node"), next=i(3, "next")}
		)
	),

	s("spush",
		fmta(
			[[
			<ptr>^, <tail> = <node>, <node0>
			<node1>.<next> = <nilv>
			]], {ptr=i(1, "ptr"), tail=i(2, "tail"), node=i(3, "node"), node0=rep(3), node1=rep(3), next=i(4, "next"), nilv=i(5, "nil")}
		)
	),

	s("spushc",
		fmta(
			[[
			<ptr>^, <tail> = <node>, <node0>
			<node1>.<next> = <nilv>
			<count> += 1
			]], {ptr=i(1, "ptr"), tail=i(2, "tail"), node=i(3, "node"), node0=rep(3), node1=rep(3), next=i(4, "next"), nilv=i(5, "nil"), count=i(6, "count")}
		)
	),

	s("spushfront",
		fmta(
			[[
			<node>.<next> = <head>
			<head0> = <node0>
			]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1)}
		)
	),

	s("spushfrontc",
		fmta(
			[[
			<node>.<next> = <head>
			<head0> = <node0>
			<count> += 1
			]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1), count=i(4, "count")}
		)
	),

	s("spopfront",
		fmta(
			[[
			<head> = <head0>.<next>
			]], {head=i(1, "head"), head0=rep(1), next=i(2,"next")}
		)
	),
	s("spopfrontc",
		fmta(
			[[
			<head> = <head0>.<next>
			<count> -= 1
			]], {head=i(1, "head"), head0=rep(1), next=i(2,"next"), count=i(3,"count")}
		)
	),

	s("dpush",
		fmta(
			[[
			<node>.<prev>, <node0>.<next> = <tail>, <nilv>
			<ptr>^, <tail0> = <node1>, <node2>
			]], {
				node=i(1, "node"), prev=i(2, "prev"), node0=rep(1), next=i(3, "next"),
				tail=i(4, "tail"), nilv=i(5, "nil"),
				ptr=i(6, "ptr"), tail0=rep(4), node1=rep(1), node2=rep(1)
			}
		)
	),

	s("dpushc",
		fmta(
			[[
			<node>.<prev>, <node0>.<next> = <tail>, <nilv>
			<ptr>^, <tail0> = <node1>, <node2>
			<count> += 1
			]], {
				node=i(1, "node"), prev=i(2, "prev"), node0=rep(1), next=i(3, "next"),
				tail=i(4, "tail"), nilv=i(5, "nil"),
				ptr=i(6, "ptr"), tail0=rep(4), node1=rep(1), node2=rep(1), count=i(7, "count")
			}
		)
	),

	s("dpushfront",
		fmta(
			[[
			<node>.<prev>, <node0>.<next> = <nilv>, <head>
			<head0> = <node0>
			]], {node=i(1, "node"), prev=i(2, "prev"), next=i(3, "next"), nilv=i(4, "nil"), head=i(5, "head"), head0=rep(5), node0=rep(1)}
		)
	),
	s("dpushfrontc",
		fmta(
			[[
			<node>.<prev>, <node0>.<next> = <nilv>, <head>
			<head0> = <node0>
			<count> += 1
			]], {node=i(1, "node"), prev=i(2, "prev"), next=i(3, "next"), nilv=i(4, "nil"), head=i(5, "head"), head0=rep(5), node0=rep(1), count=i(6, "count")}
		)
	),

	s("dremove",
		fmta(
			[[
			if <head> == <tail> {
				<head0>, <tail0> = <nilv>, <nilv0>
			} else if <head1> == <node> {
				<head2> = <head3>.<next>
				<head4>.<prev> = <nilv1>
			} else if <tail1> == <node0> {
				<tail2> = <tail3>.<prev0>
				<tail4>.<next0> = <nilv2>
			} else {
				next := <node1>.<next1>; prev := <node2>.<prev1>
				if next != nil { next.<prev2> = prev }
				if prev != nil { prev.<next2> = next }
			}
			]], { head=i(1, "head"), head0=rep(1),head1=rep(1),head2=rep(1),head3=rep(1),head4=rep(1),
				tail=i(2, "tail"), tail0=rep(2),tail1=rep(2),tail2=rep(2),tail3=rep(2),tail4=rep(2),
				nilv=i(3, "nil"), nilv0=rep(3),nilv1=rep(3),nilv2=rep(3),
				node=i(4, "node"), node0=rep(4),node1=rep(4),node2=rep(4),
				next=i(5, "next"), next0=rep(5),next1=rep(5),next2=rep(5),
				prev=i(6, "prev"), prev0=rep(6),prev1=rep(6),prev2=rep(6),
			}
		)
	),

	s("dremovec",
		fmta(
			[[
			if <head> == <tail> {
				<head0>, <tail0> = <nilv>, <nilv0>
			} else if <head1> == <node> {
				<head2> = <head3>.<next>
				<head4>.<prev> = <nilv1>
			} else if <tail1> == <node0> {
				<tail2> = <tail3>.<prev0>
				<tail4>.<next0> = <nilv2>
			} else {
				next := <node1>.<next1>; prev := <node2>.<prev1>
				if next != nil { next.<prev2> = prev }
				if prev != nil { prev.<next2> = next }
			}
			<count> -= 1
			]], { head=i(1, "head"), head0=rep(1),head1=rep(1),head2=rep(1),head3=rep(1),head4=rep(1),
				tail=i(2, "tail"), tail0=rep(2),tail1=rep(2),tail2=rep(2),tail3=rep(2),tail4=rep(2),
				nilv=i(3, "nil"), nilv0=rep(3),nilv1=rep(3),nilv2=rep(3),
				node=i(4, "node"), node0=rep(4),node1=rep(4),node2=rep(4),
				next=i(5, "next"), next0=rep(5),next1=rep(5),next2=rep(5),
				prev=i(6, "prev"), prev0=rep(6),prev1=rep(6),prev2=rep(6),
				count=i(7,"count")
			}
		)
	),

	-- -------------------------------------------------------------------------------------------------
	-- # procedure with automatic error returning
	s("perr",
		fmta(
			[[
			<value_list> := <proc>(<args>)
			if <err0> != nil {
				return <result>
			}
			<finish>
			]], {
				value_list = i(1),
				proc = i(2, "procedure"),
				args = i(3, "args"),
				err0 = f(function(value_list) return value_list_last_item(value_list[1][1]) end, {1}),
				result = d(4, odin_return_values, {1, 2}),
				finish = i(0),
			}
		)
	),
	s("ifperr",
		fmta(
			[[
			if <value_list> := <proc>(<args>); <condition> {<body>
				return <result>
			}
			]], {
				value_list = i(1),
				proc = i(2, "procedure"),
				args = i(3, "args"),
				condition = d(4, function(value_list)
					return sn(nil, i(1, value_list_last_item(value_list[1][1]) .. " != nil"))
				end, {1}),
				body = i(5),
				result = d(6, odin_return_values, {1, 2}),
			}
		)
	),

	-- -------------------------------------------------------------------------------------------------
	-- #vulkan
	s("vkci",
		fmt(
			[[
			{} :={}{} {{
				sType = .{},
				{}
			}}
			]]
		, {i(1), check_for_vulkan(), i(2), procs.to_upper(2), i(0)})
	)
})
