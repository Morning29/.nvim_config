-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/nvim-mini/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add = MiniDeps.add

add({
    source = 'nvim-telescope/telescope.nvim',
    depends = { 'nvim-lua/plenary.nvim' }
})

add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end }
})

add({
    source = 'hrsh7th/nvim-cmp',
    depends = {
        { source = 'saadparwaiz1/cmp_luasnip' },
        { source = 'hrsh7th/cmp-nvim-lsp' },
        { source = 'hrsh7th/cmp-nvim-lua' },
        { source = 'hrsh7th/cmp-cmdline' },
        { source = 'hrsh7th/cmp-path' },
        { source = 'f3fora/cmp-spell' },
    },
})

add({
    source = 'ThePrimeagen/harpoon',
    checkout = 'harpoon2',
    depends = { 'nvim-lua/plenary.nvim' },
})

add({ source = 'L3MON4D3/LuaSnip' })
add({ source = 'rafamadriz/friendly-snippets' })
add({ source = 'mbbill/undotree' })
add({ source = 'tpope/vim-fugitive' })
add({ source = 'neovim/nvim-lspconfig', })
add({ source = 'ziglang/zig.vim' })
add({ source = 'williamboman/mason.nvim' })
add({ source = 'williamboman/mason-lspconfig.nvim' })
add({ source = 'tpope/vim-repeat' })
add({ source = 'kylechui/nvim-surround' })
add({ source = 'echasnovski/mini.indentscope' })
add({ source = 'echasnovski/mini.cursorword' })
add({ source = 'tpope/vim-obsession' })
add({ source = 'folke/todo-comments.nvim' })
add({ source = 'junegunn/vim-easy-align' })
add({ source = 'lewis6991/gitsigns.nvim' })
add({ source = 'rafcamlet/nvim-luapad' })
add({ source = 'folke/flash.nvim' })
add({ source = 'norcalli/nvim-colorizer.lua' })
