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
        -- vim.keymap.set("n", "<F1>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
        -- vim.keymap.set("n", "<F2>", '<cmd>lua vim.diagnostic.goto_next({severity = "ERROR"})<cr>')
        -- vim.keymap.set("n", "<F25>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
        -- vim.keymap.set("n", "<F26>", '<cmd>lua vim.diagnostic.goto_prev({severity = "ERROR"})<cr>')

        vim.keymap.set("n", "<F1>", "<cmd>lua vim.diagnostic.jump({count = 1})<cr>")
        vim.keymap.set("n", "<F2>", '<cmd>lua vim.diagnostic.jump({count = 1, severity = "ERROR"})<cr>')
        vim.keymap.set("n", "<F25>", "<cmd>lua vim.diagnostic.jump({count = -1})<cr>")
        vim.keymap.set("n", "<F26>", '<cmd>lua vim.diagnostic.jump({count = -1, severity = "ERROR"})<cr>')

        local format_cmd = '<cmd>lua vim.lsp.buf.format({async = false})<cr>'
        -- gofmt uses tabs, don't care!
        if client.name == "gopls" then format_cmd = '<cmd>lua vim.lsp.buf.format({async = false})<cr><cmd>retab<cr>' end
        if client.name == "slangd" then client.server_capabilities.semanticTokensProvider = nil end

        vim.keymap.set('n', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format file'
        vim.keymap.set('x', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format selection'

        -- if client.name == "slangd" then
        --     vim.keymap.set('n', '<M-C-l>',
        --         function()
        --             require("conform").format({ async = true })
        --         end,
        --         { buffer = bufnr })
        --     vim.keymap.set('x', '<M-C-l>',
        --         function()
        --             require("conform").format({ async = true }, function(err)
        --                 if not err then
        --                     local mode = vim.api.nvim_get_mode().mode
        --                     if vim.startswith(string.lower(mode), "v") then
        --                         vim.api.nvim_feedkeys(
        --                             vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
        --                             "n",
        --                             true
        --                         )
        --                     end
        --                 end
        --             end)
        --         end,
        --         { buffer = bufnr })
        -- end

        vim.keymap.set('n', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>') -- Execute code action
        -- Visual mode code actions
        if vim.lsp.buf.range_code_action then
            vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>') -- Execute code action
        else
            vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>')       -- Execute code action
        end
    end,
})

vim.diagnostic.config({
    jump = { float = true, update_in_insert = false }
    -- float = true,
    -- virtual_text = true,
})

require("conform").setup({
    formatters_by_ft = {
        shaderslang = { "clang-format" },
    },
})

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "pylsp", "powershell_es", "jsonls", "slangd" }, -- "rust_analyzer", "gopls", "marksman",
    handlers = { function(server_name)
        vim.lsp.config(server_name, {
            capabilities = cmp_capabilities
        })
        vim.lsp.enable(server_name)
    end
    },
})

vim.lsp.config('slangd', {
    cmd = { 'C:/tools/Slang/bin/slangd.exe' },
    settings = {
        slang = {
            -- predefinedMacros = {"MY_VALUE_MACRO=1"},
            -- inlayHints = {
            -- deducedTypes = true,
            -- parameterNames = true,
            -- }
        }
    }
})

vim.lsp.config('powershell_es', {
    bundle_path = 'C:/tools/PowerShellEditorServices',
    shell = 'pwsh.exe',
    settings = {
        powershell = {
            codeFormatting = {
                Preset = 'OTBS'
            }
        }
    },
})

vim.lsp.config('pylsp', {
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
})

vim.lsp.config('shader-language-server', {
    capabilities = cmp_capabilities,
    cmd = { 'C:/tools/shader-language-server/shader-language-server.exe' },
    filetypes = { 'glsl', 'hlsl' },
})
vim.lsp.enable('shader-language-server')

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup("make", { clear = true }),
    callback = function(opts)
        local buf_opts = vim.bo[opts.buf]
        local ft = buf_opts.filetype
        if buf_opts.filetype == "odin" then
            buf_opts.makeprg = "odin build src -debug"
            buf_opts.errorformat = [[%f(%l:%c)\ %m]]
        elseif ft == "glsl" or ft == "shaderslang" then
            -- buf_opts.makeprg = "compile_shader.bat " .. opts.file
            buf_opts.makeprg = [[pwsh compile_shader.ps1 ]] .. opts.file
            buf_opts.errorformat = [[ERROR: %f:%l:\ %m]]
        end
    end,
})

---@class SemanticTokenModifiers
---@field declaration boolean?
---@field documentation boolean?
---@field global boolean?

---@class SemanticToken
---@field line number
---@field start_col number
---@field end_col number
---@field marked boolean
---@field type string
---@field modifiers SemanticTokenModifiers
vim.api.nvim_create_autocmd('LspTokenUpdate', {
    callback = function(args)
        --- @type SemanticToken
        local token = args.data.token
        local captures = vim.treesitter.get_captures_at_pos(args.buf, token.line, token.start_col)

        if token.type == 'function' then
            vim.lsp.semantic_tokens.highlight_token(
                token, args.buf, args.data.client_id, 'Function', { priority = 150 }
            )
        end
        if token.type == 'enum' then
            vim.lsp.semantic_tokens.highlight_token(
                token, args.buf, args.data.client_id, 'Type', { priority = 141 }
            )
        end
        for _, capture in pairs(captures) do
            if capture.capture == 'shaderslangType' then
                vim.lsp.semantic_tokens.highlight_token(
                    token, args.buf, args.data.client_id, 'Keyword', { priority = 141 }
                )
            end
        end
    end,
})

vim.lsp.config('ols', {
    capabilities = cmp_capabilities,
    init_options = {
        enable_format = true,              -- Turns on formatting with odinfmt. (Enabled by default)
        enable_hover = true,               -- Enables hover feature. (Enabled by default)
        enable_document_symbols = true,    -- Turns on outline of all your global declarations in your document. (Enabled by default)
        -- enable_fake_methods = true,             -- Turn on fake methods completion. This is currently highly experimental.
        enable_overload_resolution = true, -- Enable go-to-definition to resolve overloaded procedures from procedure groups based on call arguments.
        -- enable_references = true,          -- Turns on finding references for a symbol. (Enabled by default)
        -- enable_document_highlights = true, -- Turns on highlighting of symbol references in file. (Enabled by default)
        -- enable_document_links = true,      -- Follow links when opening documentation. This is usually done via <ctrl+click> and will open the documentation in a browser (or similar). (Enabled by default)
        -- enable_completion_matching = true, -- Attempt to match types and pointers when passing arguments to procedures. (Enabled by default)
        -- enable_inlay_hints_params = true,       -- Turn on inlay hints for (non-default) parameters.
        -- enable_inlay_hints_default_params = true, -- Turn on inlay hints for default parameters.
        -- enable_inlay_hints_implicit_return = true, -- Turn on inlay hints for implicit return values.
        enable_semantic_tokens = true,    -- Turns on syntax highlighting.
        enable_snippets = false,          -- Turns on builtin snippets
        enable_procedure_snippet = false, -- Use snippets when completing procedures—adds parenthesis after the name. (Enabled by default)
        -- enable_checker_only_saved = true,               -- Turns on only calling the checker on the package being saved. (Enabled by default)
        -- enable_checker_diagnostics_on_start = true, -- Turns on running all workspace diagnostics using odin check when starting ols (experimental).
        enable_auto_import = true,                      -- Automatically import packages that aren't in your import on completion.
        enable_comp_lit_signature_help = true,          -- Provide signature help for comp lits such as when instantiating structs. Will not display correctly on some editors such as vscode.
        enable_comp_lit_signature_help_use_docs = true, -- Put signature help for comp lits in the documentation. This will allow it to be rendered nicely using markdown in editors that render the label without colour on one line.
        -- enable_code_action_invert_if = true,         -- Enables a code action to invert if statements.
        -- odin_command = "...",                        -- Specify the location to your Odin executable, rather than relying on the environment path.
        -- odin_root_override = "...",                  -- Allows you to specify a custom ODIN_ROOT that ols will use to look for odin core libraries when implementing custom runtimes.
        verbose = false,                                                                 -- Logs warnings instead of just errors.
        checker_args = "-debug -vet-shadowing -vet-style -vet-cast -max-error-count:64", -- Pass custom arguments to odin check.
        checker_skip_packages = { "imgui", "vma", "tracy", "shaderc" },                  -- Paths to packages that should not be checked by odin check.
        collections = {
            { name = "builtin",    path = 'C:/tools/Odin/base/builtin' },
            { name = "intrinsics", path = 'C:/tools/Odin/base/intrinsics' },
            { name = "runtime",    path = 'C:/tools/Odin/base/runtime' },
            { name = "sanitizer",  path = 'C:/tools/Odin/base/sanitizer' },
            { name = "shared",     path = 'C:/tools/Odin/shared' },
            -- { name = "imgui",      path = 'C:/tools/Odin/shared/odin-imgui' },
            { name = "vendor",     path = 'C:/tools/Odin/vendor' },
        },
        -- profile = "...",                                              -- What profile to currently use.
        -- profiles = { ... },                                             -- List of different profiles that describe the environment ols is running under. This allows you to define different operating systems, architectures and defines for ols to use during development, easily switching between them using the profile configuration.
    }
})
vim.lsp.enable('ols')

vim.api.nvim_create_user_command("Odin", function(cmd)
    cmd = vim.list_extend(
        vim.list_extend({ 'odin' }, cmd.fargs), {
            '-terse-errors',
            -- '-vet-packages:main', '-vet-unused-procedures',
            -- '-vet-unused',
        }
    )

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
            vim.cmd([[ silent! Odin check src -debug ]])
            -- vim.cmd([[ Odin check verifier -debug ]])
            -- vim.cmd([[ Odin check tests -debug -no-entry-point ]])
        end
    end,
})

-- -strict-style
--         This enforces parts of same style as the Odin compiler, prefer '-vet-style -vet-semicolon' if you do not want to match it exactly.
--
--         Errs on unneeded tokens, such as unneeded semicolons.
--         Errs on missing trailing commas followed by a newline.
--         Errs on deprecated syntax.
--         Errs when the attached-brace style is not adhered to (also known as 1TBS).
--         Errs when 'case' labels are not in the same column as the associated 'switch' token.
-- -vet
--         Does extra checks on the code.
--         Extra checks include:
--                 -vet-unused
--                 -vet-unused-variables
--                 -vet-unused-imports
--                 -vet-shadowing
--                 -vet-using-stmt
-- -vet-cast
--         Errs on casting a value to its own type or using `transmute` rather than `cast`.
-- -vet-packages:<comma-separated-strings>
--         Sets which packages by name will be vetted.
--         Files with specific +vet tags will not be ignored if they are not in the packages set.
-- -vet-semicolon
--         Errs on unneeded semicolons.
-- -vet-shadowing
--         Checks for variable shadowing within procedures.
-- -vet-style
--         Errs on missing trailing commas followed by a newline.
--         Errs on deprecated syntax.
--         Does not err on unneeded tokens (unlike -strict-style).
-- -vet-tabs
--         Errs when the use of tabs has not been used for indentation.
-- -vet-unused
--         Checks for unused declarations (variables and imports).
-- -vet-unused-imports
--         Checks for unused import declarations.
-- -vet-unused-procedures
--         Checks for unused procedures.
--         Must be used with -vet-packages or specified on a per file with +vet tags.
-- -vet-unused-variables
--         Checks for unused variable declarations.
-- -vet-using-param
--         Checks for the use of 'using' on procedure parameters.
--         'using' is considered bad practice outside of immediate refactoring.
-- -vet-using-stmt
