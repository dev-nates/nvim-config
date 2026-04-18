
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
	s("imp",
		fmta([[import "<module>"]], {module=i(1, 'module')})
	),

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
	-- #arena
	s("psize",
		c(1, {
			fmta(
				[[
				<type>* <name> = push_size(<arena>, <size>);
				]], {type=i(1, "void"), name=i(2, "name"), arena=i(3, "arena"), size=i(4, "size")}
			),
			fmta(
				[[
				<name> = push_size(<arena>, <size>);
				]], {name=i(1, "name"), arena=i(2, "arena"), size=i(3, "size")}
			)
		})
	),
	s("psizenz",
		c(1, {
			fmta(
				[[
				<type>* <name> = push_size_no_zero(<arena>, <size>);
				]], {type=i(1, "void"), name=i(2, "name"), arena=i(3, "arena"), size=i(4, "size")}
			),
			fmta(
				[[
				<name> = push_size_no_zero(<arena>, <size>);
				]], {name=i(1, "name"), arena=i(2, "arena"), size=i(3, "size")}
			)
		})
	),


	s("pstruct",
		c(1, {
			fmta(
				[[
				<type> *<name> = push_struct(<arena>, <type0>);
				]], {type=i(1, "Type"), name=i(2, "name"), arena=i(3, "arena"), type0=rep(1)}
			),
			fmta(
				[[
				<name> = push_struct(<arena>, <type>);
				]], {name=i(1, "name"), arena=i(2, "arena"), type=i(3, "Type")}
			)
		})
	),
	s("pstructnz",
		c(1, {
			fmta(
				[[
				<type> *<name> = push_struct_no_zero(<arena>, <type0>);
				]], {type=i(1, "Type"), name=i(2, "name"), arena=i(3, "arena"), type0=rep(1)}
			),
			fmta(
				[[
				<name> = push_struct_no_zero(<arena>, <type>);
				]], {name=i(1, "name"), arena=i(2, "arena"), type=i(3, "Type")}
			)
		})
	),

	s("parray",
		c(1, {
			fmta(
				[[
				<type>[] <name> = push_array(<arena>, <type0>, <count>);
				]], {type=i(1, "Type"), name=i(2, "name"), arena=i(3, "arena"), type0=rep(1), count=i(4, "count")}
			),
			fmta(
				[[
				<name> = push_array(<arena>, <type>, <count>);
				]], {name=i(1, "name"), arena=i(2, "arena"), type=i(3, "Type"), count=i(4, "count")}
			)
		})
	),
	s("parraynz",
		c(1, {
			fmta(
				[[
				<type>[] <name> = push_array_no_zero(<arena>, <type0>, <count>);
				]], {type=i(1, "Type"), name=i(2, "name"), arena=i(3, "arena"), type0=rep(1), count=i(4, "count")}
			),
			fmta(
				[[
				<name> = push_array_no_zero(<arena>, <type>, <count>);
				]], {name=i(1, "name"), arena=i(2, "arena"), type=i(3, "type"), count=i(4, "count")}
			)
		})
	),

	-- -------------------------------------------------------------------------------------------------
	-- Scratch
	s("scr",
		fmta(
			[[
			Temp <scratch> = scratch_begin({<conflicts>});
			<body>
			scratch_end(<scratch0>);
			]], {scratch=i(1, "scr"), conflicts=i(2), body=i(3), scratch0=rep(1)}
		)
	),

	-- -------------------------------------------------------------------------------------------------
	-- Linked List

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
