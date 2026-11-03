do
    local ts = require('nvim-treesitter')
    local treesitter_enabled_langs = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "rust",
        "cpp",
        "zig",
        "odin",
        "python",
        "glsl",
        "markdown",
    }
    ts.install(treesitter_enabled_langs)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = treesitter_enabled_langs,
        callback = function()
            -- syntax highlighting, provided by Neovim
            vim.treesitter.start()
            -- indentation, provided by nvim-treesitter
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })

    -- NOTE 12/05/26 HSU: Default ts indentexpr doesn't currently work properly for slang.
    ts.install({ "slang" })
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { "shaderslang" },
        callback = function()
            vim.treesitter.start()
        end,
    })
end
