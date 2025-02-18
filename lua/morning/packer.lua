local function bootstrap_pckr()
    local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

    if not (vim.uv or vim.loop).fs_stat(pckr_path) then
        vim.fn.system({
            'git',
            'clone',
            "--filter=blob:none",
            'https://github.com/lewis6991/pckr.nvim',
            pckr_path
        })
    end

    vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },
    { 'ziglang/zig.vim' },
    {
        'neovim/nvim-lspconfig',
        inlay_hints = { enabled = true },
    },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/nvim-cmp',
        requires = {
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-path' },
            { 'f3fora/cmp-spell' },
        },
    },
    { 'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        requires = { { 'nvim-lua/plenary.nvim' }, },
    },
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-repeat' },
    { 'kylechui/nvim-surround' },
    { 'echasnovski/mini.indentscope' },
    { 'tpope/vim-obsession' },
    { 'folke/todo-comments.nvim' },
    { 'junegunn/vim-easy-align' },
    { 'lewis6991/gitsigns.nvim' },
    { 'rafcamlet/nvim-luapad' },
    { 'ggandor/leap.nvim' },
    { 'norcalli/nvim-colorizer.lua' },
    { 'lervag/vimtex',
        -- TO MAKE THIS WORK YOU NEED TO GO INTO ALL TEX RELATED FILES IN $VIMRUNTIME/ftplugin AND CHANGE:
        -- DEFINITION + ALL USAGES OF b:did_ftplugin  ->  b:did_my_ftplugin.
        init = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_compiler_progname = 'nvr'
            vim.g.vimtex_view_general_viewer = 'SumatraPDF'
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
            vim.cmd([[ let maplocalleader = '\' ]])
        end
    },
}
