vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id) or error("Invalid client on LspAttach")

        -- NOTE 03/11/26 HSU: Go to:
        --    - References
        --    - Definitions
        --    - Implementations
        --    - Type definitions
        --    - Symbols
        --    - In-/outgoing calls
        -- Are handled by telescope.

        do --- @format disable
            local format_cmd = '<cmd>lua vim.lsp.buf.format({async = false})<cr>'

            -- Gofmt uses tabs. Don't care! I am right, and they are wrong.
            if client.name == 'gopls' then format_cmd = '<cmd>lua vim.lsp.buf.format({async = false})<cr><cmd>retab<cr>' end
            if client.name == 'slangd' then client.server_capabilities.semanticTokensProvider = nil end

            vim.keymap.set('n', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format file'
            vim.keymap.set('x', '<M-C-l>', format_cmd, { buffer = bufnr }) -- Format selection'

            vim.keymap.set('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<cr>')
            vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
            vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
            vim.keymap.set('n', '<C-p>',      '<cmd>lua vim.lsp.buf.signature_help()<cr>') -- My beloved.
            vim.keymap.set('n', '<F6>',       '<cmd>lua vim.lsp.buf.rename()<cr>')
            vim.keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
            vim.keymap.set('n', '<F1>',       '<cmd>lua vim.diagnostic.jump({count = 1})<cr>')
            vim.keymap.set('n', '<F2>',       '<cmd>lua vim.diagnostic.jump({count = 1, severity = "ERROR"})<cr>')
            vim.keymap.set('n', '<F25>',      '<cmd>lua vim.diagnostic.jump({count = -1})<cr>')
            vim.keymap.set('n', '<F26>',      '<cmd>lua vim.diagnostic.jump({count = -1, severity = "ERROR"})<cr>')
        end

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

        vim.keymap.set('n', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

        -- Visual mode code actions
        if vim.lsp.buf.range_code_action then
            vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>') -- Execute code action
        else
            vim.keymap.set('x', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<cr>')       -- Execute code action
        end
    end,
})

require("conform").setup({
    formatters_by_ft = {
        shaderslang = { "clang-format" },
    },
})

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason').setup({
    ui = {
        icons = {
            package_installed   = "●",
            package_pending     = "●",
            package_uninstalled = "●",
        },
        keymaps = {
            install_package = 'h'
        }
    }
})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "pylsp", "powershell_es", "jsonls", "slangd", "rust_analyzer" }, -- "gopls", "marksman",
    handlers = { function(server_name)
        vim.lsp.config(server_name, {
            capabilities = cmp_capabilities
        })
        vim.lsp.enable(server_name)
    end
    },
})

vim.lsp.config('slangd', {
    -- cmd = { 'C:/tools/Slang/bin/slangd.exe' },
    capabilities = cmp_capabilities,
    settings = {
        slang = {
            -- predefinedMacros = {"MY_VALUE_MACRO=1"},
            -- inlayHints = {
            --     deducedTypes = true,
            --     parameterNames = true,
            -- }
        }
    }
})
-- vim.lsp.enable('slangd')

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
    filetypes = { 'glsl' },
})
vim.lsp.enable('shader-language-server')

-- TODO 11/04/26 HSU: Move out of this file.
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup("make", { clear = true }),
    callback = function(opts)
        local buf_opts = vim.bo[opts.buf]
        local ft = buf_opts.filetype
        if buf_opts.filetype == "odin" then
            buf_opts.makeprg = "odin build src -debug"
            buf_opts.errorformat = [[%f(%l:%c)\ %m]]
        elseif ft == "glsl" or ft == "shaderslang" then
            buf_opts.makeprg = [[pwsh compile_shaders.ps1 ]] .. opts.file
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
    end,
})

vim.lsp.config('ols', {
    capabilities = cmp_capabilities,
    init_options = {
        -- Turns on formatting with odinfmt. (Enabled by default)
        enable_format = true,

        -- Enables hover feature. (Enabled by default)
        enable_hover = true,

        -- Show the memory layout (size, alignment, field offsets and padding) of types on hover.
        -- Computed by ols from the resolved types, for the configured `profile` arch.
        -- This feature is experimental and the reported layout may not always match the compiler. _(Disabled by default)_
        enable_hover_layout = true,

        -- Turns on outline of all your global declarations in your document. (Enabled by default)
        enable_document_symbols = true,

        -- Turn on fake methods completion. This is currently highly experimental and requires client snippet support.
        enable_fake_methods = false,

        -- Enable go-to-definition to resolve overloaded procedures from procedure groups based on call arguments.
        enable_overload_resolution = true,

        -- Turns on finding references for a symbol. (Enabled by default)
        enable_references = true,

        -- Turns on highlighting of symbol references in file. (Enabled by default)
        enable_document_highlights = true,

        -- Follow links when opening documentation.
        -- This is usually done via <ctrl+click> and will open the documentation in a browser (or similar). (Enabled by default)
        enable_document_links = true,

        -- Enables completion results. _(Enabled by default)_
        enable_completions = true,

        -- Attempt to match types and pointers when passing arguments to procedures. (Enabled by default)
        enable_completion_matching = true,

        -- Turn on reporting of unused imported packages. _(Enabled by default)_
        enable_unused_imports_reporting = true,

        -- Report unused imported packages after each document change. This can slow editing in large files. _(Disabled by default)_
        enable_unused_imports_on_change = false,

        -- Turn on inlay hints for (non-default) parameters.
        enable_inlay_hints_params = true,

        -- Turn on inlay hints for default parameters.
        enable_inlay_hints_default_params = true,

        -- Turn on inlay hints for implicit return values.
        enable_inlay_hints_implicit_return = true,

        -- Adds inlay hints for unhandled optional result value. (#optional_ok and #optional_allocator_error)
        enable_inlay_hints_optional_result = true,

        -- Turns on syntax highlighting.
        enable_semantic_tokens = true,

        -- Turns on builtin snippets
        enable_snippets = false,

        -- Use snippets when completing procedures—adds parenthesis after the name. This requires client snippet support. _(Enabled by default)_
        enable_procedure_snippet = false,

        -- Turns on only calling the checker on the package being saved. (Enabled by default)
        enable_checker_only_saved = true,

        -- TODO 17/10/26 HSU: Test this.
        -- Enables compiler semantics for reporting type information. This is currently experimental and under active development.
        -- Needs an `odin` with `-export-semantics`.
        enable_compiler_semantics = true,

        -- Turns on calling the checker on the package being edited once typing pauses for `checker_on_change_delay`,
        -- with the unsaved text of the open documents. Needs an `odin` with `-overlay`.
        enable_checker_on_change = true,

        -- How long typing must pause, in milliseconds, before `enable_checker_on_change` calls the checker. _(Defaults to 400)_
        checker_on_change_delay = 1000,

        -- Fades the branches of `when` statements that the checker did not take. Needs an `odin` with `-export-semantics`. _(Enabled by default)_
        enable_fade_untaken_when_branches = true,

        -- Turns on running all workspace diagnostics using odin check. This is currently experimental and may cause problems.
        -- A better option is using the `checker_path` feature to explicity tell `ols` the projects that it should check. (experimental).
        enable_checker_workspace_diagnostics = false,

        -- Automatically import packages that aren't in your import on completion.
        enable_auto_import = true,

        -- Skip hidden directories when discovering packages for auto-import. _(Enabled by default)_
        enable_auto_import_skip_hidden_paths = true,

        -- Provide signature help for comp lits such as when instantiating structs.
        -- Will not display correctly on some editors such as vscode.
        enable_comp_lit_signature_help = true,

        -- Put signature help for comp lits in the documentation.
        -- This will allow it to be rendered nicely using markdown in editors that render the label without colour on one line.
        enable_comp_lit_signature_help_use_docs = true,

        -- Enables a code action to invert if statements.
        enable_code_action_invert_if = true,

        --   Controls visibility of struct fields starting with `_`:
        -- - `""` (default): no hiding, all fields are visible
        -- - `"file"`: hide fields when accessed from outside the declaring file
        -- - `"package"`: hide fields when accessed from outside the declaring package
        struct_fields_underscore_visibility = "",

        -- Enable real-time diagnostics from `core:odin/parser`. _(Enabled by default)_
        enable_parser_errors = true,

        -- Enable real-time diagnostics from the lsp. _(Enabled by default)_
        enable_diagnostics = true,

        -- Specify the location to your Odin executable, rather than relying on the environment path.
        -- odin_command = "...",

        -- Allows you to specify a custom ODIN_ROOT that ols will use to look for odin core libraries when implementing custom runtimes.
        -- odin_root_override = "...",

        -- Pass custom arguments to odin check.
        checker_args = "-debug -vet-shadowing -vet-style -vet-cast -vet-nil-deref -vet-atomic-access -vet-when-shadowing",
        -- TODO 03/11/26 HSU: -max-error-count:64 was broken the last time I tried using it. Might work again whenever updating OLS.

        -- Paths to packages that should not be checked by odin check.
        checker_skip_packages = { "old_imgui", "new_imgui", "imgui", "vma", "tracy", "shaderc" },

        -- Filter procedures that include the provided attributes from completions. For example `@(test)`.
        completion_exclude_attributes = {},

        -- Logs warnings instead of just errors.
        verbose = false, -- Logs warnings instead of just errors.

        -- What profile to currently use.
        -- profile = "...",

        -- List of different profiles that describe the environment ols is running under. This allows you to define different operating systems, architectures and defines for ols to use during development, easily switching between them using the profile configuration.
        -- profiles = { ... },

        collections = {
            { name = "builtin",    path = 'C:/tools/Odin/base/builtin' },
            { name = "intrinsics", path = 'C:/tools/Odin/base/intrinsics' },
            { name = "runtime",    path = 'C:/tools/Odin/base/runtime' },
            { name = "sanitizer",  path = 'C:/tools/Odin/base/sanitizer' },
            { name = "shared",     path = 'C:/tools/Odin/shared' },
            { name = "vendor",     path = 'C:/tools/Odin/vendor' },
        },
    }
})
vim.lsp.enable('ols')

vim.api.nvim_create_user_command("Odin", function(cmd)
    cmd = vim.list_extend(
        vim.list_extend({ 'odin' }, cmd.fargs), {
            '-terse-errors',
            '-vet-shadowing',
            '-vet-style',
            '-vet-cast',
            '-vet-nil-deref',
            '-vet-atomic-access',
            '-vet-when-shadowing',
            -- '-vet-unused-imports',
            -- '-vet-packages:main',
            -- '-vet-unused-procedures',
            -- '-vet-unused',
        }
    )

    local command_res = vim.system(cmd):wait()

    if command_res.stdout == "" then command_res.stdout = nil end
    if command_res.stderr == "" then command_res.stderr = nil end

    vim.notify(vim.inspect(command_res))

    if command_res.code == 0 and command_res.stdout ~= nil then
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
            -- vim.cmd([[ silent! Odin check src -debug ]])
            vim.cmd([[ silent! Odin check src src_hot_reload_ui -workspace -debug ]])
        end
    end,
})
