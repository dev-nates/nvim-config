local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = "v"
vim.g.maplocalleader = "v"

-- Reload config
keymap("n", "<leader>r", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })

-- Change <C-c> to escape
keymap("n", "<C-c>", "<Esc>", opts)

-- Enter can be used to save everything
keymap("n", "<cr>", "<cmd>wa<cr>", opts)

-- Set space to NOP (I forgot why I did this)
-- keymap("", "<Space>", "<Nop>", opts)
keymap("i", "<C-space>", "<space>", opts)

-- Change insert mode indent keymap
keymap("i", "<C-t>", "<nop>", opts)
keymap("i", "<C-_>", "<C-t>", opts)

-- Delete backwards by whitespace
keymap("i", "<C-x>", "<C-o>dB", opts)
keymap("i", "<C-backspace>", "<c-w>", opts)

-- Bind helpful arrow key movements in insert mode
keymap("i", "<S-Left>", "<C-o>B", opts)
keymap("i", "<S-Right>", "<C-o>W", opts)
keymap("n", "<S-Left>", "B", opts)
keymap("n", "<S-Right>", "W", opts)

keymap({ "n", "i" }, "<S-Up>", "<Up>", opts)
keymap({ "n", "i" }, "<S-Down>", "<Down>", opts)

-- Better window navigation
keymap("n", "<A-S-j>", "<C-w>j", opts)
keymap("n", "<A-S-h>", "<C-w>h", opts)
keymap("n", "<A-S-k>", "<C-w>k", opts)
keymap("n", "<A-S-l>", "<C-w>l", opts)
keymap("n", "<A-S-c>", "<C-w>q", opts)
keymap("n", "<A-S-x>", "<C-w>o", opts)
keymap("n", "<A-S-s>", "<C-w>v", opts)

-- Scroll using J/K
keymap("n", "<c-k>", "<c-y>", opts)
keymap("n", "<c-j>", "<c-e>", opts)

-- Switch to visual mode using space
keymap("n", " ", "v", opts)
keymap("n", "v", "<Nop>", opts)

-- Make D and d the same in visual mode
-- D deletes lines rather that the selected text for (visual select)
-- Since there's visual line mode, I figure I don't need this.
keymap("v", "D", "d", opts)
keymap("v", "C", "c", opts)

-- Resize with arrows
-- keymap("n", "<A-S-J>", ":resize +2<CR>", opts)
-- keymap("n", "<A-S-K>", ":resize -2<CR>", opts)
-- keymap("n", "<A-S-T>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<A-S-H>", ":vertical resize +2<CR>", opts)

-- Goto Start/End of line keybinds
-- _ remains the same
keymap({"n", "v"}, "<A-h>", "_", opts)
keymap({"n", "v"}, "<A-l>", "g_", opts)


-- Unmap these because of muscle memory
keymap("n", "<S-h>", "<nop>", opts)
keymap("n", "<S-t>", "<nop>", opts)


-- Make it easier to use j/k to jump around with numbered jumps e.g. 5) will be 5k
keymap({ "n", "v", "x" }, "(", "k", opts)
keymap({ "n", "v", "x" }, ")", "j", opts)

-- Exit insert mode
keymap("i", "<C-c>", "<Esc>", opts)

-- A-P paste in insert mode
keymap("i", "<A-cr>", "<cr>", opts)
keymap("i", "<A-p>", "<Esc>pa", opts)

-- Don't override register when pasting in visual mode
-- keymap("v", "<c-p>", '"_dP', opts)

-- Escape visual mode when pressing space
keymap("v", " ", "<Esc>", opts)

-- Quicker visual indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)

-- Telescope
-- keymap("t", "<C-l>", "<C-\\><C-N><C-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>h", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>s", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
keymap("n", "<leader>S", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>t", "<cmd>Telescope tags<cr>", opts)

-- NETRW
keymap("n", "<leader>n", ":Lex 30<cr>", opts)

-- NvimTree
keymap("n", "<leader>f", "<cmd>NvimTreeToggle<cr>", opts)

-- Undo Tree
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", opts)

-- Comment box
keymap({ "n", "v", "x" }, "<leader>cb", "<cmd>CBclbox<cr>vip=<esc>", opts)
keymap({ "n", "v", "x" }, "<leader>ch", "<cmd>CBllline<cr>V=<esc>", opts)

-- @Todo: Keymap for generating tag file
-- Goto to tag under cursor
keymap("n", "<A-g>", "<c-]>", opts)

-- Unhighlight
keymap("n", "\\", "<cmd>noh<cr>", opts)

-- Move up/down by scope
keymap({ "n", "v" }, "{", "[{")
keymap({ "n", "v" }, "}", "]}")

-- Move up/down by paragraph
keymap({"n", "v" }, "<A-5>", "{")
keymap({"n", "v" }, "<A-3>", "}")

-- Barbar
--[[
keymap("n", "<A-x>", "<cmd>BufferClose<cr>", opts)
keymap("n", "<A-g>", "<cmd>BufferPrevious<cr>", opts)
keymap("n", "<A-c>", "<cmd>BufferNext<cr>", opts)
keymap("n", "<A-,>", "<cmd>BufferMovePrevious<cr>", opts)
keymap("n", "<A-.>", "<cmd>BufferMoveNext<cr>", opts)
]]--

