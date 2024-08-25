vim.g.mapleader = " "
vim.keymap.set({ "n", "i", "v" }, "<C-h>", "<nop>")

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
    callback = function(_)
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 300 })
    end,
})

-- Configure terminal to send F15 on ctrl+enter
vim.keymap.set("i", "<F15>",
    "<cmd>set formatoptions+=r<cr><cr><cmd>set formatoptions-=r<cr>",
    { noremap = true, silent = true })
vim.keymap.set("i", "<CR>",
    "<cmd>set formatoptions-=r<cr><cr>",
    { noremap = true, silent = true })
vim.keymap.set("n", "<C-o>",
    "<cmd>set formatoptions+=o<cr>o<cmd>set formatoptions-=o<cr>",
    { noremap = true, silent = true })
vim.keymap.set("n", "o",
    "<cmd>set formatoptions-=o<cr>o",
    { noremap = true, silent = true })
-- This doesn't work but I won't care until I find myself needing it.
-- vim.keymap.set("n", "<C-S-O>",
--     "<cmd>set formatoptions+=o<cr>O<cmd>set formatoptions-=o<cr>",
-- { noremap = true, silent = true })
vim.keymap.set("n", "O",
    "<cmd>set formatoptions-=o<cr>O",
    { noremap = true, silent = true })

-- Don't get stuck in terminal mode
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Clear search
vim.keymap.set("i", "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true })

-- ijkl
vim.keymap.set("", "i", "k", { noremap = true, silent = true })
vim.keymap.set("", "j", "h", { noremap = true, silent = true })
vim.keymap.set("", "k", "j", { noremap = true, silent = true })
vim.keymap.set("", "h", "i", { noremap = true, silent = true })

-- https://github.com/tpope/vim-fugitive/issues/1425#issuecomment-995106715
-- tpope plugins use 'h' in place of 'i'
vim.cmd([[
    let g:nremap = {'i': 'h'}
    let g:xremap = {'i': 'h'}
    let g:oremap = {'i': 'h'}
]])

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-J>", "<C-W>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = true, silent = true })
-- Configure terminal to send F14 on ctrl+i
vim.keymap.set("n", "<F14>", "<C-W>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-W>j", { noremap = true, silent = true })

vim.keymap.set("n", "<M-i>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("n", "<M-k>", "<cmd>m .+1<cr>==", { desc = "Move down" })

vim.keymap.set("i", "<M-k>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<M-i>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })

vim.keymap.set("v", "<M-k>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<M-i>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Stay in place when using J
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true })

-- TODO: Do this for everything that fucks with registers
-- Delete to black hole register
vim.keymap.set("n", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("n", "D", '"_D', { noremap = true, silent = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true })

-- Change to black hole register
vim.keymap.set("n", "c", '"_c', { noremap = true, silent = true })
vim.keymap.set("n", "C", '"_C', { noremap = true, silent = true })
vim.keymap.set("n", "cc", '"_cc', { noremap = true, silent = true })
vim.keymap.set("v", "c", '"_c', { noremap = true, silent = true })

-- Change char to black hole register
vim.keymap.set("n", "s", '"_s', { noremap = true, silent = true })
vim.keymap.set("n", "S", '"_S', { noremap = true, silent = true })
vim.keymap.set("v", "s", '"_s', { noremap = true, silent = true })

-- Replace visually selected text to black hole register
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })
vim.keymap.set("x", "<M-p>", '"*dP', { noremap = true, silent = true })

vim.keymap.set("n", "<M-y>", '"*y', { noremap = true, silent = true })
vim.keymap.set("i", "<M-y>", '"*y', { noremap = true, silent = true })
vim.keymap.set("x", "<M-y>", '"*y', { noremap = true, silent = true })

vim.keymap.set("n", "<M-p>", '"*p', { noremap = true, silent = true })
vim.keymap.set("i", "<M-p>", '"*p', { noremap = true, silent = true })
vim.keymap.set("x", "<M-p>", '"*p', { noremap = true, silent = true })

-- Cut to yank register
vim.keymap.set("n", "x", '"+d', { noremap = true, silent = true })
vim.keymap.set("n", "X", '"+D', { noremap = true, silent = true })
vim.keymap.set("n", "xx", '"+dd', { noremap = true, silent = true })
vim.keymap.set("v", "x", '"+d', { noremap = true, silent = true })

vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pss", [[<cmd>Obsess<cr>]], {})
vim.keymap.set("n", "<leader>psd", [[<cmd>Obsess!<cr>]], {})
vim.keymap.set("n", "<leader>pp", [[<cmd>so Session.vim<cr>]], {})

vim.keymap.set("n", "<leader>gg", vim.cmd.Git);

-- Quick fix
vim.keymap.set("n", "<leader>qq", "<cmd>crewind<CR>")
vim.keymap.set("n", "<leader>qlq", "<cmd>lrewind<CR>")
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>qN", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>qln", "<cmd>next<CR>")
vim.keymap.set("n", "<leader>qlN", "<cmd>lprev<CR>")

-- Search/replace word under cursor.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left><Space><Backspace>]])

-- vim-easy-align
vim.keymap.set("x", "<leader>a", "<Plug>(EasyAlign)")
vim.keymap.set("n", "<leader>a", "<Plug>(EasyAlign)")
