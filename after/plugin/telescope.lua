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
        -- fname_width = 60,
        layout_config = {
            vertical = { width = 0.5 },
            horizontal = { width = 0.9 },
            -- other layout configuration here
        },
        -- other defaults configuration here
    },
    pickers = {
        lsp_definitions = { fname_width = 60 }
    }
    -- other configuration values here
})

-- require('telescope.builtin').lsp_references({
--     path_display = { "smart" },
--     fname_width = 60,
-- })
--
-- require('telescope.builtin').lsp_definitions({
--     path_display = { "smart" },
--     fname_width = 60,
-- })
--
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "TelescopePreviewerLoaded",
--   callback = function(args)
--     if args.data.filetype ~= "help" then
--       vim.wo.number = true
--     elseif args.data.bufname:match("*.csv") then
--       vim.wo.wrap = false
--     end
--   end,
-- })
--
