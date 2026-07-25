
-- lazy.nvim
return {
	"folke/snacks.nvim",

	---@type snacks.Config
	opts = {
		indent = {
			priority = 1,
			enabled = true,
			only_scope = false,
			only_current = false,
			hl = 'SnacksIndent',

			animate = {
				enabled = false,
				style = "down",
				easing = "outExpo",
				step = 1,
				duration = 10,
			},
		}
	}
}
