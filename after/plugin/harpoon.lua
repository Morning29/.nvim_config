local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>hma", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hmm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>hl", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>h;", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>h'", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(9) end)
vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(10) end)
vim.keymap.set("n", "<leader>hg", function() harpoon:list():select(11) end)

vim.keymap.set("n", "<leader>hn", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hp", function() harpoon:list():next() end)

