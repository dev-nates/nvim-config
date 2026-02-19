local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

-- -------------------------------------------------------------------------------------------------
-- Compilation (quickfix)

-- @Todo: Be able to specify the makeprg during runtime via `change_makeprg()` or something.
local build_string = "./build.sh"
local function change_build_string()
	build_string = vim.fn.input("Set build string:")
end
keymap("n", "<leader>b", change_build_string, opts)

local function build_project()
	vim.cmd('wa')
	-- vim.opt.makeprg = "./build.sh"
	-- vim.cmd('silent make')

	-- -------------------------------------------------------------------------------------------------
	-- Run build script
	local tmp = "/tmp/nvim_cfile.txt"
	local output = vim.fn.system(build_string)
	local lines = vim.split(output, '\n')
	local status = vim.v.shell_error
	vim.fn.writefile(lines, tmp)

	-- -------------------------------------------------------------------------------------------------
	-- Open qflist if there are errors, else close the list.
	if status ~= 0 then
		local current = vim.api.nvim_get_current_win()
		vim.cmd('botright copen')
		vim.api.nvim_set_current_win(current)
		-- @Note: We do a nvim_win_call here so that cfile+first doesn't affect the window view of other windows that have the same file as the error
		vim.api.nvim_win_call(current, function()
			vim.cmd('cfile ' .. tmp)
			vim.cmd('cfirst')
		end)
	else
		vim.fn.setqflist({}, ' ', {lines=lines})
		vim.cmd('cclose')
		print('COMPILE SUCCESS')
	end
end

vim.keymap.set("n", "<C-b>", build_project)
vim.keymap.set("i", "<C-b>", function()
	build_project();
	local keys = vim.api.nvim_replace_termcodes("<esc>l", true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end)

vim.api.nvim_create_user_command('CNext', function()
	local ok = pcall(vim.cmd, 'cnext')
	if not ok then
		vim.cmd('cfirst')
	end
end, {})
vim.api.nvim_create_user_command('CPrev', function()
	local ok = pcall(vim.cmd, 'cprev')
	if not ok then
		vim.cmd('clast')
	end
end, {})
vim.keymap.set("n", "<A-n>", "<cmd>CNext<CR>")
vim.keymap.set("n", "<A-p>", "<cmd>CPrev<CR>")

