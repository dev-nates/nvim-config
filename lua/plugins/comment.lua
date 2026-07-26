

local config = function()

	local ft = require('Comment.ft')
	ft.set('odin', { '%//%s', '/*%s*/' })

	local opts = {
		pre_hook = nil,
		post_hook = nil,
	}
	require("Comment").setup(opts)
end


return {}
-- return {
-- 	{
-- 		"numToStr/Comment.nvim",
-- 		config = config,
-- 	},
-- }
