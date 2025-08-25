local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

local keymap = vim.keymap.set

keymap("n", "<leader>a", function() harpoon:list():add() end)
keymap("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

keymap("n", "<C-h>", function() harpoon:list():select(1) end)
keymap("n", "<C-t>", function() harpoon:list():select(2) end)
keymap("n", "<C-n>", function() harpoon:list():select(3) end)
keymap("n", "<C-s>", function() harpoon:list():select(4) end)
keymap("n", "<C-_>", function() harpoon:list():select(5) end)

-- Toggle previous & next buffers stored within Harpoon list
keymap("n", "<C-S-P>", function() harpoon:list():prev() end)
keymap("n", "<C-S-N>", function() harpoon:list():next() end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        -- previewer = conf.file_previewer({}),
        previewer = false,
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>e", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
