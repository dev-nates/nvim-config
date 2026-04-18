
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

	s("name",
		fmta(
			[[
			typedef name <name0> <name1>;
			name <name> {
				<body>
			};
			]], {name=i(1), name0=rep(1), name1=rep(1), body=i(2)}
		)
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

	s("structnode",
		fmta(
			[[
			typedef name <name0> <name1>;
			name <name> {
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


	-- -------------------------------------------------------------------------------------------------
	-- #stack
	s("stkpush", c(1, {
			fmta(
				[[
				<node>->><next> = <head>; <head0> = <node0>;
				]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1)}
			),
			fmta(
				[[
				<node>.<next> = <head>; <head0> = <node0>;
				]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1)}
			),
		})
	),

	s("stkpushc", c(1, {
			fmta(
				[[
				<node>->><next> = <head>; <head0> = <node0>;
				<count> += 1
				]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1), count=i(4, "count")}
			),
			fmta(
				[[
				<node>->><next> = <head>; <head0> = <node0>;
				<count> += 1
				]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1), count=i(4, "count")}
			),
		})
	),

	s("stkpop", c(1, {
			fmta(
				[[
				<head> = <head0>->><next>;
				]], {head=i(1, "head"), head0=rep(1), next=i(2, "next")}
			),
			fmta(
				[[
				<head> = <head0>.<next>;
				]], {head=i(1, "head"), head0=rep(1), next=i(2, "next")}
			),
		})
	),

	s("stkpopc", c(1, {
			fmta(
				[[
				<head> = <head0>->><next>;
				<count> -= 1;
				]], {head=i(1, "head"), head0=rep(1), next=i(2, "next"), count=i(3, "count")}
			),
			fmta(
				[[
				<head> = <head0>.<next>;
				<count> -= 1;
				]], {head=i(1, "head"), head0=rep(1), next=i(2, "next"), count=i(3, "count")}
			),
		})
	),

	s("flpush", c(1, {
			fmta(
				[[
				<node>->><next> = <freelist>; <freelist0> = <node0>;
				asan_poison(<node1>, size_of(*<node2>));
				]], {node=i(1, "node"), next=i(2, "next"), freelist=i(3, "freelist"), freelist0=rep(3), node0=rep(1), node1=rep(1), node2=rep(1)}
			),
			fmta(
				[[
				<node>.<next> = <freelist>; <freelist0> = <node0>;
				asan_poison(<node1>, size_of(*<node2>));
				]], {node=i(1, "node"), next=i(2, "next"), freelist=i(3, "freelist"), freelist0=rep(3), node0=rep(1), node1=rep(1), node2=rep(1)}
			),
		})
	),

	s("flpushc", c(1, {
			fmta(
				[[
				<node>->><next> = <freelist>; <freelist0> = <node0>;
				asan_poison(<node1>, size_of(*<node2>));
				<count> += 1;
				]], {node=i(1, "node"), next=i(2, "next"), freelist=i(3, "freelist"), freelist0=rep(3), node0=rep(1), node1=rep(1), node2=rep(1), count=i(4, "count") }
			),
			fmta(
				[[
				<node>.<next> = <freelist>; <freelist0> = <node0>;
				asan_poison(<node1>, size_of(*<node2>));
				<count> += 1;
				]], {node=i(1, "node"), next=i(2, "next"), freelist=i(3, "freelist"), freelist0=rep(3), node0=rep(1), node1=rep(1), node2=rep(1), count=i(4, "count") }
			),
		})
	),

	s("flpop", c(1, {
			fmta(
				[[
				<type> *<node> = <freelist>;
				if (!check_nil(<node0>, <nilv>)) {
					asan_cure(<node1>, size_of(*<node2>));
					<freelist0> = <freelist1>->><next>;
				} else {
					<node3> = push_struct_no_zero(<arena>, <type0>);
				}
				memory_zero_struct(<node4>);
				]], {
					type=i(1, "Node"), node=i(2, "node"), freelist=i(3, "freelist"),
					node0=rep(2), nilv=i(4, "nil"), node1=rep(2), node2=rep(2), freelist0=rep(3), freelist1=rep(3),
					next=i(5, "next"), node3=rep(2), type0=rep(1), arena=i(6, "arena"), node4=rep(2),
				}
			),
			fmta(
				[[
				<type> *<node> = <freelist>;
				if (!check_nil(<node0>, <nilv>)) {
					asan_cure(<node1>, size_of(*<node2>));
					<freelist0> = <freelist1>.<next>;
				} else {
					<node3> = push_struct_no_zero(<arena>, <type0>);
				}
				memory_zero_struct(<node4>);
				]], {
					type=i(1, "Node"), node=i(2, "node"), freelist=i(3, "freelist"),
					node0=rep(2), nilv=i(4, "nil"), node1=rep(2), node2=rep(2), freelist0=rep(3), freelist1=rep(3),
					next=i(5, "next"), node3=rep(2), type0=rep(1), arena=i(6, "arena"), node4=rep(2),
				}
			),
		})
	),


	s("flpopc", c(1, {
			fmta(
				[[
				<type> *<node> = <freelist>;
				if (!check_nil(<node0>, <nilv>)) {
					asan_cure(<node1>, size_of(*<node2>));
					<freelist0> = <freelist1>->><next>;
					<count> -= 1;
				} else {
					<node3> = push_struct_no_zero(<arena>, <type0>);
				}
				memory_zero_struct(<node4>);
				]], {
					type=i(1, "Node"), node=i(2, "node"), freelist=i(3, "freelist"),
					node0=rep(2), nilv=i(4, "nil"), node1=rep(2), node2=rep(2), freelist0=rep(3), freelist1=rep(3),
					next=i(5, "next"), count=i(6, "count"), node3=rep(2), type0=rep(1), arena=i(7, "arena"), node4=rep(2),
				}
			),
			fmta(
				[[
				<type> *<node> = <freelist>;
				if (!check_nil(<node0>, <nilv>)) {
					asan_cure(<node1>, size_of(*<node2>));
					<freelist0> = <freelist1>.<next>;
					<count> -= 1;
				} else {
					<node3> = push_struct_no_zero(<arena>, <type0>);
				}
				memory_zero_struct(<node4>);
				]], {
					type=i(1, "Node"), node=i(2, "node"), freelist=i(3, "freelist"),
					node0=rep(2), nilv=i(4, "nil"), node1=rep(2), node2=rep(2), freelist0=rep(3), freelist1=rep(3),
					next=i(5, "next"), count=i(6, "count"), node3=rep(2), type0=rep(1), arena=i(7, "arena"), node4=rep(2),
				}
			),
		})
	),

	-- -------------------------------------------------------------------------------------------------
	-- #linked list
	s("lptr",
		fmta(
			[[
			<type> **<ptr> = check_nil(<head>, <nilv>) ? &<head0> : &<tail>->><next>;
			]], { type=i(1, "Node"), ptr=i(2, "ptr"), head=i(3, "head"), nilv=i(4, "nil"), head0=rep(3), tail=i(5, "tail"), next=i(6, "next"), }
		)
	),

	s("ptrnext",
		fmta(
			[[
			<ptr> = &<node>->><next>;
			]], {ptr=i(1, "ptr"), node=i(2, "node"), next=i(3, "next")}
		)
	),

	s("spush",
		fmta(
			[[
			*<ptr> = <node>; <tail> = <node0>;
			<node1>->><next> = <nilv>;
			]], {ptr=i(1, "ptr"), node=i(2, "node"), tail=i(3, "tail"), node0=rep(2), node1=rep(2), next=i(4, "next"), nilv=i(5, "nil"), }
		)
	),

	s("spushc",
		fmta(
			[[
			*<ptr> = <node>; <tail> = <node0>;
			<node1>->><next> = <nilv>;
			<count> += 1;
			]], {ptr=i(1, "ptr"), node=i(2, "node"), tail=i(3, "tail"), node0=rep(2), node1=rep(2), next=i(4, "next"), nilv=i(5, "nil"), count=i(6, "count")}
		)
	),

	s("spushfront",
		fmta(
			[[
			<node>->><next> = <head>;
			<head0> = <node0>;
			]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1)}
		)
	),
	s("spushfrontc",
		fmta(
			[[
			<node>->><next> = <head>;
			<head0> = <node0>;
			<count> += 1;
			]], {node=i(1, "node"), next=i(2, "next"), head=i(3, "head"), head0=rep(3), node0=rep(1), count=i(4, "count")}
		)
	),

	s("spopfront",
		fmta(
			[[
			<head> = <head0>->><next>;
			]], {head=i(1, "head"), head0=rep(1), next=i(2, "next")}
		)
	),

	s("spopfrontc",
		fmta(
			[[
			<head> = <head0>->><next>;
			<count> -= 1;
			]], {head=i(1, "head"), head0=rep(1), next=i(2, "next"), count=i(3, "count")}
		)
	),

	s("dpush",
		fmta(
			[[
			<node>->><prev> = <tail>; <node0>->><next> = <nilv>;
			*<ptr> = <node1>; <tail0> = <node2>;
			]], {
				node=i(1, "node"), prev=i(2, "prev"), tail=i(3, "tail"), node0=rep(1), next=i(4, "next"), nilv=i(5, "nil"),
				ptr=i(6, "ptr"), node1=rep(1), tail0=rep(3), node2=rep(1),
			}
		)
	),

	s("dpushc",
		fmta(
			[[
			<node>->><prev> = <tail>; <node0>->><next> = <nilv>;
			*<ptr> = <node1>; <tail0> = <node2>;
			<count> += 1;
			]], {
				node=i(1, "node"), prev=i(2, "prev"), tail=i(3, "tail"), node0=rep(1), next=i(4, "next"), nilv=i(5, "nil"),
				ptr=i(6, "ptr"), node1=rep(1), tail0=rep(3), node2=rep(1), count=i(7, "count"),
			}
		)
	),

	s("dpushfront",
		fmta(
			[[
			<node>->><prev> = <nilv>; <node0>->><next> = <head>;
			<head0> = <node0>;
			]], {
				node=i(1, "node"), prev=i(2, "prev"), nilv=i(3, "nil"), node0=rep(1), next=i(4, "next"), head=i(5, "head"),
				head0=rep(5), node0=rep(1),
			}
		)
	),

	s("dpushfrontc",
		fmta(
			[[
			<node>->><prev> = <nilv>; <node0>->><next> = <head>;
			<head0> = <node0>;
			<count> += 1;
			]], {
				node=i(1, "node"), prev=i(2, "prev"), nilv=i(3, "nil"), node0=rep(1), next=i(4, "next"), head=i(5, "head"),
				head0=rep(5), node0=rep(1), count=i(6, "count")
			}
		)
	),

	s("dremove",
		fmta(
			[[
			if (<head> == <tail>) {
				<head0> = <nilv>; <tail0> = <nilv0>;
			} else if (<head1> == <node>) {
				<head2> = <head3>->><next>;
				<head4>->><prev> = <nilv1>;
			} else if (<tail1> == <node0>) {
				<tail2> = <tail3>->><prev0>;
				<tail4>->><next0> = <nilv2>;
			} else {
				<type> *next = <node1>->><next1>;
				<type0> *prev = <node2>->><prev1>;
				if (!check_nil(next, <nilv3>)) { next->><prev2> = prev; }
				if (!check_nil(prev, <nilv4>)) { prev->><next2> = next; }
			}
			]], {
				head=i(1, "head"), tail=i(2, "tail"),
				head0=rep(1), nilv=i(3, "nil"), tail0=rep(2), nilv0=rep(3),
				head1=rep(1), node=i(4, "node"),
				head2=rep(1), head3=rep(1), next=i(5, "next"),
				head4=rep(1), prev=i(6, "prev"), nilv1=rep(3),
				tail1=rep(2), node0=rep(4),
				tail2=rep(2), tail3=rep(2), prev0=rep(6),
				tail4=rep(2), next0=rep(5), nilv2=rep(3),
				type=i(7, "Type"), node1=rep(4), next1=rep(5),
				type0=rep(7), node2=rep(4), prev1=rep(6),
				nilv3=rep(3), prev2=rep(6),
				nilv4=rep(3), next2=rep(5),
			}
		)
	),

	s("dremovec",
		fmta(
			[[
			if (<head> == <tail>) {
				<head0> = <nilv>; <tail0> = <nilv0>;
			} else if (<head1> == <node>) {
				<head2> = <head3>->><next>;
				<head4>->><prev> = <nilv1>;
			} else if (<tail1> == <node0>) {
				<tail2> = <tail3>->><prev0>;
				<tail4>->><next0> = <nilv2>;
			} else {
				<type> *next = <node1>->><next1>;
				<type0> *prev = <node2>->><prev1>;
				if (!check_nil(next, <nilv3>)) { next->><prev2> = prev; }
				if (!check_nil(prev, <nilv4>)) { prev->><next2> = next; }
			}
			<count> -= 1;
			]], {
				head=i(1, "head"), tail=i(2, "tail"),
				head0=rep(1), nilv=i(3, "nil"), tail0=rep(2), nilv0=rep(3),
				head1=rep(1), node=i(4, "node"),
				head2=rep(1), head3=rep(1), next=i(5, "next"),
				head4=rep(1), prev=i(6, "prev"), nilv1=rep(3),
				tail1=rep(2), node0=rep(4),
				tail2=rep(2), tail3=rep(2), prev0=rep(6),
				tail4=rep(2), next0=rep(5), nilv2=rep(3),
				type=i(7, "Type"), node1=rep(4), next1=rep(5),
				type0=rep(7), node2=rep(4), prev1=rep(6),
				nilv3=rep(3), prev2=rep(6),
				nilv4=rep(3), next2=rep(5),
				count=i(8, "count"),
			}
		)
	),
}

ls.add_snippets("c", snippets)
