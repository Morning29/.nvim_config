vim.cmd('colorscheme simplerdarcula')

vim.opt.rnu = true
vim.opt.nu = true

vim.opt.pumheight = 30

vim.opt.conceallevel = 0
vim.opt.cursorline = true
-- guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
vim.opt.guicursor = 'n-v-c-sm:block-blinkwait250-blinkon250-blinkoff250,i-ci-ve:ver25-blinkwait250-blinkon250-blinkoff250,r-cr-o:hor20-blinkwait250-blinkon250-blinkoff250'


vim.opt.ignorecase = true
vim.opt.inccommand = 'nosplit'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = -- ~\AppData\Local\nvim-data\undo\
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 4

vim.opt.more = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 500
vim.opt.list = true

vim.opt.foldenable = false
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
-- formatoptions=jcroql
vim.opt.formatoptions:append({
    -- Attempt to remove comment char(s) when joining comment lines with 'J'
    j = true,
    -- Autowrap comments when reaching 'textwidth'
    c = true,
    -- Automatically insert comment char(s) when pressing <Enter> in insert mode
    r = true,
    -- Automatically insert comment char(s) when using 'o' and 'O'
    o = true,
    -- Allow formatting of comments iwth 'gq'
    q = true,
    -- Don't format long lines in insert mode
    l = true,
})


vim.opt.cmdheight = 1
vim.opt.autowrite = true
vim.opt.laststatus = 2
vim.opt.shiftround = true
vim.opt.showmode = false

vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true

vim.opt.smartcase = true

vim.opt.splitkeep = "screen"

vim.opt.virtualedit = "block,onemore"
vim.opt.wildmode = "longest:full,full"

vim.opt.fillchars = {
    foldopen = "V",
    foldclose = ">",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
