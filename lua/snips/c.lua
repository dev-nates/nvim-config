
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

function trim_surrounding_whitespace(s)
   return s:match( "^%s*(.-)%s*$" )
end

-- -------------------------------------------------------------------------------------------------
-- #snippets

local snippets = {
	-- -------------------------------------------------------------------------------------------------
	-- #general
	s("inc",
		fmta([[#include "<path>"]], {path=i(1, 'path')})
	),

	s("proc", c(1, {
		fmta(
			[[
			proc <ret>
			<name>(<args>) {
				<body>
			}
			]], { name=i(1, "procedure"), args=i(2, "void"), ret=i(3, "void"), body=i(4) }
		),
		fmta(
			[[
			proc <ret>
			<name>(
				<args>
			) {
				<body>
			}
			]], { name=i(1, "procedure"), args=i(2, "void"), ret=i(3, "void"), body=i(4) }
		),
		fmta(
			[[
			proc <ret> <name>(<args>) { <body> }
			]], { name=i(1, "procedure"), args=i(2, "void"), ret=i(3, "void"), body=i(4) }
		),
		})
	),

	s("procd", c(1, {
			fmta(
				[[
				proc <ret>
				<name>(<args>);
				]], {name=i(1, "procedure"), args=i(2, "void"), ret=i(3, "void")}
			),
			fmta(
				[[
				proc <ret> <name>(<args>);
				]], {name=i(1, "procedure"), args=i(2, "void"), ret=i(3, "void")}
			),
		})
	),

	s("union", c(1, {
			fmta(
				[[
				union <name> {
					<body>
				};
				]], {name=i(1), body=i(2)}
			),
			fmta(
				[[
				typedef union <name0> <name1>;
				union <name> {
					<body>
				};
				]], {name=i(1), name0=rep(1), name1=rep(1), body=i(2)}
			),
		})
	),

	s("struct",
		fmta(
			[[
			typedef struct <name0> <name1>;
			struct <name> {
				<body>
			};
			]], {name=i(1, "Node"), name0=rep(1), name1=rep(1), body=i(2) }
		)
	),

	s("structnode",
		fmta(
			[[
			typedef struct <name0> <name1>;
			struct <name> {
				<name2> *<next>;
				<body>
			};
			]], {name=i(1, "Node"), name0=rep(1), name1=rep(1), name2=rep(1), next=i(2, "next"), body=i(3) }
		)
	),

	s("enum", c(1, {
			fmta(
				[[
				typedef <type> <name0>;
				enum <name> {
					<body>
				};
				]], {name=i(1), name0=rep(1), type=i(2), body=i(3)}
			),
			fmta(
				[[
				typedef enum <name0> <name1>;
				enum <name> {
					<body>
				};
				]], {name=i(1), name0=rep(1), name1=rep(1), body=i(2)}
			),
			fmta(
				[[
				typedef <type> <name0>;
				enum <name> {
					<body>
					<name1>_COUNT,
				};
				]], {name=i(1), name0=rep(1), name1=rep(1), type=i(2), body=i(3)}
			),
			fmta(
				[[
				typedef enum <name0> <name1>;
				enum <name> {
					<body>
					<name2>_COUNT,
				};
				]], {name=i(1), name0=rep(1), name1=rep(1), name2=rep(1), body=i(2)}
			),
		})
	),

	-- -------------------------------------------------------------------------------------------------
	-- #arena
	s("psize",
		c(1, {
			fmta(
				[[
				rawptr <name> = push_size(<arena>, <size>);
				]], {name=i(1), arena=i(2, "arena"), size=i(3, "size")}
			),
			fmta(
				[[
				<name> = push_size(<arena>, <size>);
				]], {name=i(1), arena=i(2, "arena"), size=i(3, "size")}
			)
		})
	),
	s("psizenz",
		c(1, {
			fmta(
				[[
				rawptr <name> = push_size_no_zero(<arena>, <size>));
				]], {name=i(1), arena=i(2, "arena"), size=i(3, "size")}
			),
			fmta(
				[[
				<name> = push_size_no_zero(<arena>, <size>);
				]], {name=i(1), arena=i(2, "arena"), size=i(3, "size")}
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
				]], {name=i(1), arena=i(2, "arena"), type=i(3, "Type")}
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
				]], {name=i(1), arena=i(2, "arena"), type=i(3, "Type")}
			)
		})
	),

	s("parray",
		c(1, {
			fmta(
				[[
				<type> *<name> = push_array(<arena>, <type0>, <count>);
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
				<type> *<name> = push_array_no_zero(<arena>, <type0>, <count>);
				]], {type=i(1, "Type"), name=i(2, "name"), arena=i(3, "arena"), type0=rep(1), count=i(4, "count")}
			),
			fmta(
				[[
				<name> = push_array_no_zero(<arena>, <type>, <count>);
				]], {name=i(1), arena=i(2, "arena"), type=i(3, "type"), count=i(4, "count")}
			)
		})
	),

	-- -------------------------------------------------------------------------------------------------
	-- Scratch
	
	s("scr", c(1, {
			fmta(
				[[
				Temp <scratch> = scratch_begin(<conflicts>, <count>);
				<body>
				scratch_end(<scratch0>);
				]], {scratch=i(1, "scr"), conflicts=i(2, "0"), count=i(3, "0"), body=i(4), scratch0=rep(1)}
			),
			fmta(
				[[
				Temp <scratch> = scratch_begin(<conflicts>, <count>);
				<body>
				scratch_end(<scratch0>);
				]], {scratch=i(1, "scr"), conflicts=i(2, "&arena"), count=i(3, "1"), body=i(4), scratch0=rep(1)}
			),
		})
	),
}

ls.add_snippets("c", snippets)
