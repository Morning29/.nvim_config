local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fF', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
-- vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>fS', builtin.lsp_dynamic_workspace_symbols, {})

vim.keymap.set('n', '<leader>gi', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>go', builtin.lsp_outgoing_calls, {})

vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>gt', builtin.lsp_type_definitions, {})

require('telescope').setup({
    defaults = {
        -- path_display = { "absolute" },
        layout_strategy = 'flex',
        layout_config = {
            vertical = {
                height = 0.9,
                preview_cutoff = 40,
                prompt_position = "bottom",
                width = 0.8
            },
            horizontal = {
                height = 0.9,
                preview_cutoff = 190,
                prompt_position = "bottom",
                width = 0.8
            },
        },
        -- border = false,

        dynamic_preview_title = true,
        results_title = false,
        preview_title = false,
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }, -- { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        selection_caret = '  ',
        file_ignore_patterns = { "%.ttf" },
    },
    pickers = {
        lsp_definitions = { fname_width = 60 }
    }
})

local harpoon = require('harpoon')

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
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hmt", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
