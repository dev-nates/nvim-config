
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
  box_width = 100, -- width of the boxes
  line_width = 100, -- width of the lines
  borders = { -- symbols used to draw a box
    top = "-",
    bottom = "-",
    left = "|",
    right = "|",
    top_left = "+",
    top_right = "+",
    bottom_left = "+",
    bottom_right = "+",
  },
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
