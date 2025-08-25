local opts = {
	init_options = {
		checker_args = "-strict-style",
		collections = {
			{ name = "shared", path = vim.fn.expand('$HOME/projects/odin-lib') }
		},
	},
}
return opts
