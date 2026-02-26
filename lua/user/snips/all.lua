
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

ls.add_snippets("all", {
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
				<freelist> = <freelist0>.<next>
				]], {assign=i(1, "node := freelist"),
				assign0=f(function(assign)
					local parts = vim.split(assign[1][1], " ", true)
					return parts[1]
				end, {1}),
				freelist=i(2, "freelist"), freelist0=rep(2), next=i(3, "next")}
			),
			fmta(
				[[
				sanitizer.address_unpoison(<node>)
				<freelist> = <freelist0>.<next>
				]], { node=i(1), freelist=i(2, "freelist"), freelist0=rep(2), next=i(3, "next")}
			),
			fmta(
				[[
				<freelist> = <freelist0>.<next>
				]], {freelist=i(1, "freelist"), freelist0=rep(1), next=i(2, "next")}
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
			{} := (base.chknil({}, {})) ? &{} : &{}.{}
			]], {i(1, "ptr"), i(2, "head"), i(3, "nil"), rep(2), i(4, "tail"), i(5, "next") }
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
})
