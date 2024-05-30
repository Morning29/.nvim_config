local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')                    -- Hover documentation'
    vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')      -- Go to definition'
    vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')     -- Go to declaration'
    vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')  -- Go to implementation'
    vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>') -- Go to type definition'
    vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>')      -- Go to reference'
    vim.keymap.set('n', '<C-p>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')       -- Show function signature'
    vim.keymap.set('n', '<F6>', '<cmd>lua vim.lsp.buf.rename()<cr>')                -- Rename symbol'
    vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<cr>')   -- Show diagnostic'
    vim.keymap.set("n", "<F1>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
    vim.keymap.set("n", "<F2>", '<cmd>lua vim.diagnostic.goto_next({severity = "ERROR"})<cr>')

    -- gofmt uses tabs, don't care!
    if client.name == "gopls" then
        local format_cmd = '<cmd>lua vim.lsp.buf.format({async = false})<cr><cmd>retab<cr>'
        vim.keymap.set('n', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format file'
        vim.keymap.set('x', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format selection'
    else
        local format_cmd = '<cmd>lua vim.lsp.buf.format({async = true})<cr>'
        vim.keymap.set('n', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format file'
        vim.keymap.set('x', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format selection'
    end


    vim.keymap.set('n', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>') -- Execute code action
    -- Visual mode code actions
    if vim.lsp.buf.range_code_action then
        vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>') -- Execute code action
    else
        vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>')       -- Execute code action
    end
end)


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "zls", "gopls" },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end
    }
})

lsp_zero.setup()
