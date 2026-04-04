
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

-- Unbind C-Space in insert mode
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
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)
keymap("n", "<A-c>", "<C-w>q", opts)
keymap("n", "<A-r>", "<C-w>r", opts)
keymap("n", "<A-x>", "<C-w>o", opts)
keymap("n", "<A-s>", "<C-w>v", opts)

-- Scroll using J/K
keymap("n", "<c-k>", "<c-y>", opts)
keymap("n", "<c-j>", "<c-e>", opts)

-- Switch to visual mode using space
keymap("n", "<space>", "v", opts)
keymap("n", "<C-space>", "v", opts)
keymap("n", "v", "<Nop>", opts)

-- Resize with arrows
-- keymap("n", "<A-S-J>", ":resize +2<CR>", opts)
-- keymap("n", "<A-S-K>", ":resize -2<CR>", opts)
-- keymap("n", "<A-S-T>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<A-S-H>", ":vertical resize +2<CR>", opts)

-- Goto Start/End of line keybinds

keymap({"n", "x"}, "<S-h>", "_", opts)
keymap({"n", "x"}, "<S-l>", "g_", opts)

-- keymap({"n", "x"}, "<A-h>", "_", opts)
-- keymap({"n", "x"}, "<A-l>", "g_", opts)

-- keymap("n", "<S-h>", "h", opts)
-- keymap("n", "<S-l>", "l", opts)

-- Make it easier to use j/k to jump around with numbered jumps e.g. 5) will be 5k
keymap({ "n", "x" }, "(", "k", opts)
keymap({ "n", "x" }, ")", "j", opts)

-- Exit insert mode
keymap("i", "<C-c>", "<Esc>", opts)

-- A-P paste in insert mode
keymap("i", "<A-cr>", "<cr>", opts)
keymap("i", "<A-p>", "<Esc>pa", opts)

-- Don't override register when pasting in visual mode
-- keymap("x", "<c-p>", '"_dP', opts)

-- Escape visual mode when pressing space
keymap("x", " ", "<Esc>", opts)

-- Quicker visual indenting
keymap("x", "<", "<gv", opts)
keymap("x", ">", ">gv", opts)

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
keymap({ "n", "x" }, "<leader>cb", "<cmd>CBclbox<cr>vip=<esc>", opts)
keymap({ "n", "x" }, "<leader>ch", "<cmd>CBllline<cr>V=<esc>", opts)

-- @Todo: Keymap for generating tag file
-- Goto to tag under cursor
keymap("n", "<A-g>", "<c-]>", opts)

-- Unhighlight
keymap("n", "\\", "<cmd>noh<cr>", opts)

-- Move up/down by scope
keymap({ "n", "x" }, "{", "[{")
keymap({ "n", "x" }, "}", "]}")

-- Move up/down by paragraph

-- @Note: This mess prevents the jump-list from being polluted
keymap({"n", "x"}, 'U', function()
	vim.cmd("keepjumps normal! " .. vim.v.count1 .. "{")
end, opts)
keymap({"n", "x"}, 'D', function()
	vim.cmd("keepjumps normal! " .. vim.v.count1 .. "}")
end, opts)

keymap({"n"}, "X", "D")
keymap({"x"}, "C", "<nop>");

