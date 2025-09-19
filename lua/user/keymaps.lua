local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = "v"
vim.g.maplocalleader = "v"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Change <C-c> to escape
keymap("n", "<C-c>", "<Esc>", opts)

-- Enter can be used to save everything
keymap("n", "<cr>", "<cmd>wa<cr>", opts)

-- Scroll using J/K
keymap("n", "<c-k>", "<c-y>", opts)
keymap("n", "<c-j>", "<c-e>", opts)

-- Switch to visual mode using space
keymap("n", " ", "v", opts)

-- Unbind weird key
keymap("i", "<C-space>", "<space>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Start/End of line keybinds
keymap({ "n", "v", "x" }, "<S-h>", "_", opts)
keymap({ "n", "v", "x" }, "<S-l>", "g_", opts)

-- Make it easier to use j/k jumps for my keyboard layout.
keymap({ "n", "v", "x" }, "(", "k", opts)
keymap({ "n", "v", "x" }, ")", "j", opts)

-- Stop highlight
keymap("n", "\\", "<cmd>noh<cr>", opts)

-- Insert --
keymap("i", "<C-c>", "<Esc>", opts)
keymap("i", "<C-v>", "<Esc>pa", opts)
-- keymap("i", "<C-backspace>", "<C-w>", opts)
-- keymap("i", "<C-h>", "<C-w>", opts)

-- Visual --
keymap("v", "p", '"_dP', opts)
keymap("v", " ", "<Esc>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)

-- Telescope
-- keymap("t", "<C-l>", "<C-\\><C-N><C-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>h", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>s", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
keymap("n", "<leader>S", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>t", "<cmd>Telescope tags<cr>", opts)

-- NETRW
-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- NvimTree
keymap("n", "<leader>f", "<cmd>NvimTreeToggle<cr>", opts)

-- Undo Tree
keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>", opts)

-- Comment box
keymap({ "n", "v", "x" }, "<leader>cb", "<cmd>CBclbox<cr>vip=<esc>", opts)
keymap({ "n", "v", "x" }, "<leader>ch", "<cmd>CBllline<cr>V=<esc>", opts)

-- Ctags
keymap("n", "<A-t>", "<c-]>", opts)

-- Compilation (quickfix)

-- @Todo: Be able to specify the makeprg during runtime via `change_makeprg()` or something.
vim.opt.makeprg = "./build.sh"
local function build_project()
  vim.cmd('wa | silent make')
end
vim.keymap.set("n", "<C-b>", build_project)
vim.keymap.set("i", "<C-b>", function()
	build_project();
	local keys = vim.api.nvim_replace_termcodes("<esc>l", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end)
vim.keymap.set("n", "<A-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<A-p>", "<cmd>cprev<CR>")
