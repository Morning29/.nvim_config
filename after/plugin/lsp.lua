vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id) or error("Invalid client on LspAttach")

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')                    -- Hover documentation'
        -- vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')      -- Go to definition'
        vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')     -- Go to declaration'
        vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')  -- Go to implementation'
        vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>') -- Go to type definition'
        -- vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>')      -- Go to reference'
        vim.keymap.set('n', '<C-p>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')       -- Show function signature'
        vim.keymap.set('n', '<F6>', '<cmd>lua vim.lsp.buf.rename()<cr>')                -- Rename symbol'
        vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<cr>')   -- Show diagnostic'
        vim.keymap.set("n", "<F1>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
        vim.keymap.set("n", "<F2>", '<cmd>lua vim.diagnostic.goto_next({severity = "ERROR"})<cr>')
        vim.keymap.set("n", "<F25>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
        vim.keymap.set("n", "<F26>", '<cmd>lua vim.diagnostic.goto_prev({severity = "ERROR"})<cr>')

        -- gofmt uses tabs, don't care!
        local format_cmd = '<cmd>lua vim.lsp.buf.format({async = true})<cr>'
        if client.name == "gopls" then format_cmd = '<cmd>lua vim.lsp.buf.format({async = false})<cr><cmd>retab<cr>' end

        vim.keymap.set('n', '<M-C-l>', format_cmd, { buffer = bufnr })          -- Format file'
        vim.keymap.set('x', '<M-C-l>', format_cmd, { buffer = bufnr })          -- Format selection'

        vim.keymap.set('n', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>') -- Execute code action
        -- Visual mode code actions
        if vim.lsp.buf.range_code_action then
            vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>') -- Execute code action
        else
            vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>')       -- Execute code action
        end
    end,
})

vim.api.nvim_create_user_command("Odin", function(cmd)
    cmd = vim.list_extend(vim.list_extend({ 'odin' }, cmd.fargs), { '-terse-errors' })

    local command_res = vim.system(cmd):wait()

    if command_res.code == 0 and command_res.stdout ~= nil then
        print(command_res.stdout)
        vim.fn.setqflist({})
        vim.cmd([[ cwindow ]])
        return
    end

    if command_res.stderr == nil then
        vim.fn.setqflist({})
        vim.cmd([[ cwindow ]])
        return
    end

    local err_lines = vim.split(command_res.stderr, '\n', { plain = true, trimempty = true })

    vim.fn.setqflist({}, 'r', {
        efm = [[%f(%l:%c)\ %m]],
        lines = err_lines,
    })
end, { nargs = '+' })


vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup("odin check", { clear = true }),
    callback = function(opts)
        if vim.bo[opts.buf].filetype == "odin" then
            -- HACK 25/02/25 HSU: Won't work in odin projects without /src.
            vim.cmd([[ Odin check src -debug ]])
        end
    end,
})


vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup("odin make", { clear = true }),
    callback = function(opts)
        local buf_opts = vim.bo[opts.buf]
        if buf_opts.filetype == "odin" then
            buf_opts.makeprg = "odin build src -debug"
            buf_opts.errorformat = [[%f(%l:%c)\ %m]]
        end
    end,
})


vim.api.nvim_create_autocmd('LspTokenUpdate', {
    callback = function(args)
        local token = args.data.token
        if token.type == 'function' then
            vim.lsp.semantic_tokens.highlight_token(
                token, args.buf, args.data.client_id, 'Function', { priority = 150 }
            )
        end
    end,
})

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "marksman", "pylsp", "powershell_es", "jsonls", "glsl_analyzer" },
    -- handlers = nil,
    handlers = { function(server_name)
        require('lspconfig')[server_name].setup({
            capabilities = cmp_capabilities
        })
    end
    },
})

require 'lspconfig'.powershell_es.setup {
    bundle_path = 'C:/tools/PowerShellEditorServices',
    shell = 'pwsh.exe',
}

require 'lspconfig'.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W391' },
                    maxLineLength = 1000
                }
            }
        }
    }
}

require("lspconfig").ols.setup { -- Server-specific settings. See `:help lspconfig-setup`
    capabilities = cmp_capabilities,
    init_options = {
        enable_hover = true,
        enable_snippets = true,
        enable_procedure_snippet = false,
        enable_semantic_tokens = true,
        enable_references = true,
        enable_document_symbols = true,
        checker_args = "-debug -vet-shadowing -vet-style -vet-cast", -- -vet-unused", -- -vet-casts -vet-using-param",
        verbose = true,
        enable_rename = true,
        enable_inlay_hints = true,
        -- enable_checker_only_saved = false,
        -- enable_fake_methods = false,
        collections = {
            { name = "builtin",    path = 'C:/tools/Odin/base/builtin' },
            { name = "intrinsics", path = 'C:/tools/Odin/base/intrinsics' },
            { name = "runtime",    path = 'C:/tools/Odin/base/runtime' },
        },
    },
}

require("lspconfig").zls.setup({ -- Server-specific settings. See `:help lspconfig-setup`
    capabilities = cmp_capabilities,
    -- Perhaps handle link formatting in hover doc:
    -- handlers = {
    --     ["textDocument/hover"] = function (_, result, ctx, config)
    --         local old_hover = vim.lsp.handlers.hover
    --         print("result:")
    --         vim.print(result)
    --         print("ctx:")
    --         vim.print(ctx)
    --         print("config:")
    --         vim.print(config)
    --     end
    -- },

    -- Further information on how to configure ZLS: https://github.com/zigtools/zls/wiki/Configuration
    settings = {
        zls = {
            -- enable_snippets: Enables snippet completions when the client also supports them. (default: true)
            enable_snippets = true,
            -- enable_argument_placeholders: Whether to enable function argument placeholder completions. (default: true)
            enable_argument_placeholders = false,
            -- semantic_tokens: Set level of semantic tokens. Partial only includes information that requires semantic analysis.. enum: [ none, partial, full ], (default: full)
            semantic_tokens = "none",
            -- zig_lib_path: Zig library path, e.g. `/path/to/zig/lib/zig`, used to analyze std library imports. (default: null)
            zig_lib_path = "C:/tools/zig-windows-x86_64-0.13.0/lib",
            -- completion_label_details: When false, the function signature of completion results is hidden. Improves readability in some editors. (default: true)
            completion_label_details = true,

            -- enable_build_on_save: Whether to enable build-on-save diagnostics. (default: false)
            -- build_on_save_step: Select which step should be executed on build-on-save. (default: install)
            -- enable_autofix: Whether to automatically fix errors on save. Currently supports adding and removing discards.. (default: false)
            -- inlay_hints_show_variable_type_hints: Enable inlay hints for variable types. (default: true)
            -- inlay_hints_show_struct_literal_field_type: Enable inlay hints for fields in struct and union literals. (default: true)
            -- inlay_hints_show_parameter_name: Enable inlay hints for parameter names. (default: true)
            -- inlay_hints_show_builtin: Enable inlay hints for builtin functions. (default: true)
            -- inlay_hints_exclude_single_argument: Don't show inlay hints for single argument calls. (default: true)
            -- inlay_hints_hide_redundant_param_names: Hides inlay hints when parameter name matches the identifier (e.g. foo: foo). (default: false)
            -- inlay_hints_hide_redundant_param_names_last_token: Hides inlay hints when parameter name matches the last token of a parameter node (e.g. foo: bar.foo, foo: &foo). (default: false)
            -- warn_style: Enables warnings for style guideline mismatches. (default: false)
            -- highlight_global_var_declarations: Whether to highlight global var declarations. (default: false)
            -- skip_std_references: When true, skips searching for references in std. Improves lookup speed for functions in user's code. Renaming and go-to-definition will continue to work as is. (default: false)
            -- prefer_ast_check_as_child_process: Favor using `zig ast-check` instead of ZLS's fork. (default: true)
            -- builtin_path: Path to 'builtin;' useful for debugging, automatically set if let null. (default: null)
            -- zig_exe_path: Zig executable path, e.g. `/path/to/zig/zig`, used to run the custom build runner. If `null`, zig is looked up in `PATH`. Will be used to infer the zig standard library path if none is provided. (default: null)
            -- build_runner_path: Path to the `build_runner.zig` file provided by ZLS. null is equivalent to `${executable_directory}/build_runner.zig`. (default: null)
            -- global_cache_path: Path to a directory that will be used as zig's cache. null is equivalent to `${KnownFolders.Cache}/zls`. (default: null)
        }
    }
})
