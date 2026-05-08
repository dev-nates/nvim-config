
local ls = require "luasnip"
local procs = require "snips.procs"

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


local snippets = {
	s("proc", c(1, {
		fmta(
			[[
			fn <ret>
			<name>(<args>) {
				<body>
			}
			]], { name=i(1, "procedure"), args=i(2), ret=i(3, "void"), body=i(4) }
		),
		fmta(
			[[
			fn <ret>
			<name>(
				<args>
			) {
				<body>
			}
			]], { name=i(1, "procedure"), args=i(2), ret=i(3, "void"), body=i(4) }
		),
		fmta(
			[[
			fn <ret> <name>(<args>) { <body> }
			]], { name=i(1, "procedure"), args=i(2), ret=i(3, "void"), body=i(4) }
		),
		})
	),

	s("procb", c(1, {
		fmta(
			[[
			fn <ret>
			<name>(<args>) @builtin {
				<body>
			}
			]], { name=i(1, "procedure"), args=i(2), ret=i(3, "void"), body=i(4) }
		),
		fmta(
			[[
			fn <ret>
			<name>(
				<args>
			) @builtin {
				<body>
			}
			]], { name=i(1, "procedure"), args=i(2), ret=i(3, "void"), body=i(4) }
		),
		fmta(
			[[
			fn <ret> <name>(<args>) @builtin { <body> }
			]], { name=i(1, "procedure"), args=i(2), ret=i(3, "void"), body=i(4) }
		),
		})
	),

	s("if", c(1, {
			fmta(
				[[
				if (<cond>) {
					<body>
				}
				]], {cond=i(1), body=i(2)}
			),
			fmta(
				[[
				if (<cond>) { <body> }
				]], {cond=i(1), body=i(2)}
			),
		})
	),

	s("else",
		fmta(
			[[
			else {
				<body>
			}
			]], {body=i(1)}
		)
	),

	s("elseif",
		fmta(
			[[
			else if (<cond>) {
				<body>
			}
			]], {cond=i(1), body=i(2)}
		)
	),

	s("for",
		fmta(
			[[
			for (<cond>) {
				<body>
			}
			]], {cond=i(1), body=i(2)}
		)
	),

	s("foreach",
		fmta(
			[[
			foreach (<cond>) {
				<body>
			}
			]], {cond=i(1), body=i(2)}
		)
	),

	s("struct",
		fmta(
			[[
			struct <name> {
				<body>
			}
			]], {name=i(1, "Struct"), body=i(2)}
		)
	),

	s("snode",
		fmta(
			[[
			struct <name> {
				<name2> *<next>;
				<body>
			}
			]], {name=i(1, "Node"), name2=rep(1), next=i(2, "next"), body=i(3) }
		)
	),

	s("dnode",
		fmta(
			[[
			struct <name> {
				<name2> *<next>; <name3> *<prev>;
				<body>
			}
			]], {name=i(1, "Node"), name2=rep(1), next=i(2, "next"), name3=rep(1), prev=i(3, "prev"), body=i(4) }
		)
	),

	s("union",
		fmta(
			[[
			union <name> {
				<body>
			}
			]], {name=i(1, "Union"), body=i(2)}
		)
	),

	s("enum", c(1, {
			fmta(
				[[
				enum <name>: <type> {
					<body>
				}
				]], {name=i(1, "Enum"), type=i(2, "long"), body=i(3)}
			),
			fmta(
				[[
				enum <name>: <type> (<values>) {
					<body>
				}
				]], {name=i(1, "Enum"), type=i(2, "long"), values=i(3), body=i(4)}
			),
		})
	),

	-- -------------------------------------------------------------------------------------------------
	-- ┌             ┐
	-- │ Linked List │
	-- └             ┘
	
	-- -------------------------------------------------------------------------------------------------
	-- Stack
	s("stkpush",
		fmta(
			[[
			@stkpush(<head>, <node>);
			]], {head=i(1, "head"), node=i(2, "node")}
		)
	),
	s("stkpushc",
		fmta(
			[[
			@stkpushc(<head>, <count>, <node>);
			]], {head=i(1, "head"), count=i(2, "count"), node=i(3, "node")}
		)
	),
	s("stkpop",
		fmta(
			[[
			@stkpop(<head>);
			]], {head=i(1, "head")}
		)
	),
	s("stkpopc",
		fmta(
			[[
			@stkpop(<head>, <count>);
			]], {head=i(1, "head"), count=i(2, "count")}
		)
	),

	-- -------------------------------------------------------------------------------------------------
	-- Freelist
	s("flpush",
		fmta(
			[[
			@flpush(<head>, <node>);
			]], {head=i(1, "head"), node=i(2, "node")}
		)
	),
	s("flpushc",
		fmta(
			[[
			@flpushc(<head>, <count>, <node>);
			]], {head=i(1, "head"), count=i(2, "count"), node=i(3, "node")}
		)
	),
	s("flpop",
		fmta(
			[[
			@flpop(<head>);
			]], {head=i(1, "head")}
		)
	),
	s("flpopc",
		fmta(
			[[
			@flpopc(<head>, <count>);
			]], {head=i(1, "head"), count=i(2, "count")}
		)
	),


	-- -------------------------------------------------------------------------------------------------
	-- Single Linked List
	s("spush",
		fmta(
			[[
			@spush(<head>, <tail>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), node=i(3, "node")}
		)
	),

	s("spushc",
		fmta(
			[[
			@spushc(<head>, <tail>, <count>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count"), node=i(4, "node")}
		)
	),
	
	s("spushfront",
		fmta(
			[[
			@spushfront(<head>, <tail>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), node=i(3, "node") }
		)
	),

	s("spushfrontc",
		fmta(
			[[
			@spushfrontc(<head>, <tail>, <count>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count"), node=i(4, "node") }
		)
	),

	s("spopfront",
		fmta(
			[[
			@spopfront(<head>, <tail>);
			]], {head=i(1, "head"), tail=i(2, "tail") }
		)
	),

	s("spopfrontc",
		fmta(
			[[
			@spopfrontc(<head>, <tail>, <count>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count") }
		)
	),

	-- -------------------------------------------------------------------------------------------------
	-- Double Linked List

	s("dpush",
		fmta(
			[[
			@dpush(<head>, <tail>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), node=i(3, "node")}
		)
	),
	s("dpushc",
		fmta(
			[[
			@dpushc(<head>, <tail>, <count>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count"), node=i(4, "node")}
		)
	),

	s("dpop",
		fmta(
			[[
			@dpop(<head>, <tail>);
			]], {head=i(1, "head"), tail=i(2, "tail")}
		)
	),
	s("dpopc",
		fmta(
			[[
			@dpushc(<head>, <tail>, <count>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count")}
		)
	),

	s("dpushfront",
		fmta(
			[[
			@dpushfront(<head>, <tail>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), node=i(3, "node")}
		)
	),
	s("dpushfrontc",
		fmta(
			[[
			@dpushfrontc(<head>, <tail>, <count>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count"), node=i(4, "node")}
		)
	),

	s("dpopfront",
		fmta(
			[[
			@dpopfront(<head>, <tail>);
			]], {head=i(1, "head"), tail=i(2, "tail")}
		)
	),
	s("dpopfrontc",
		fmta(
			[[
			@dpopfrontc(<head>, <tail>, <count>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count")}
		)
	),

	s("dremovec",
		fmta(
			[[
			@dremovec(<head>, <tail>, <count>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), count=i(3, "count"), node=i(4, "node")}
		)
	),

	s("dremove",
		fmta(
			[[
			@dremove(<head>, <tail>, <node>);
			]], {head=i(1, "head"), tail=i(2, "tail"), node=i(3, "node")}
		)
	),
}

ls.add_snippets("c3", snippets)
