
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set



local cbox_indent = function(cmd)
	-- Save current visual selection marks

	local getp = function()
		local start_pos = vim.fn.getpos("v")
		local end_pos = vim.fn.getpos(".")

		if start_pos[2] > end_pos[2] then
			local temp = start_pos
			start_pos = end_pos
			end_pos = temp
		end
		return start_pos, end_pos
	end

	-- Run command and get the selection
	local start_pos, end_pos = getp();
	end_pos[2] = end_pos[2] + 2;
	vim.cmd(cmd)

	-- -- Reselect the expanded region
	vim.fn.setpos("'<", start_pos)
	vim.fn.setpos("'>", end_pos)
	vim.cmd("normal! gv")

	-- -- Reindent this region
	vim.cmd("normal! =")

	print(vim.inspect(start_pos), vim.inspect(end_pos));
end

local cbox_delete = function()
	-- Save current visual selection marks

	local getp = function()
		local start_pos = vim.fn.getpos("v")
		local end_pos = vim.fn.getpos(".")

		if start_pos[2] > end_pos[2] then
			local temp = start_pos
			start_pos = end_pos
			end_pos = temp
		end
		return start_pos, end_pos
	end

	-- Run command and get the selection
	vim.cmd("CBd")
	local start_pos, end_pos = getp();

	-- -- Reselect the expanded region
	vim.fn.setpos("'<", start_pos)
	vim.fn.setpos("'>", end_pos)
	vim.cmd("normal! gv")

	-- -- Reindent this region
	vim.cmd("normal! =")

	end_pos[2] = end_pos[2] - 2;
	end_pos[3] = 2147483647; -- max col
	vim.fn.setpos("'>", end_pos)
	vim.cmd("normal! gv")

	local keys = vim.api.nvim_replace_termcodes("gcgv=", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end

-- Comment box
keymap({ "n", "x" }, "VE", function() cbox_indent("CBlabox") end, opts)
keymap({ "n", "x" }, "VU", function() cbox_indent("CBlabox18") end, opts)
keymap({ "n", "x" }, "VH", "<cmd>CBllline<cr><esc>V=", opts)
keymap({ "n", "x" }, "VD", function() cbox_delete() end, opts)

local config = function()
	local status_ok, cbox = pcall(require, "comment-box")
	if not status_ok then
		return
	end

	cbox.setup({
	  -- type of comments:
	  --   - "line":  comment-box will always use line style comments
	  --   - "block": comment-box will always use block style comments
	  --   - "auto":  comment-box will use block line style comments if
	  --              multiple lines are selected, line style comments
	  --              otherwise
	  comment_style = "line",
	  doc_width = 100, -- width of the document
	  box_width = 80, -- width of the boxes
	  line_width = 100, -- width of the lines
	  -- borders = { -- symbols used to draw a box
	  --   top = "-",
	  --   bottom = "-",
	  --   left = "|",
	  --   right = "|",
	  --   top_left = "+",
	  --   top_right = "+",
	  --   bottom_left = "+",
	  --   bottom_right = "+",
	  -- },
	  lines = { -- symbols used to draw a line
	    line = "-",
	    line_start = "-",
	    line_end = "-",
	    title_left = "-",
	    title_right = "-",
	  },
	  outer_blank_lines_above = false, -- insert a blank line above the box
	  outer_blank_lines_below = false, -- insert a blank line below the box
	  inner_blank_lines = false, -- insert a blank line above and below the text
	  line_blank_line_above = false, -- insert a blank line above the line
	  line_blank_line_below = false, -- insert a blank line below the line
	})
end

return {
	{
		"LudoPinelli/comment-box.nvim",
		config = config,
	},
}
