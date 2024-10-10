require('leap').opts.safe_labels = {}

vim.keymap.set('n', ',', '<Plug>(leap)')
vim.keymap.set('n', '<leader>,', '<Plug>(leap-from-window)')
-- vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap-forward)')
-- vim.keymap.set({ 'x', 'o' }, 'S', '<Plug>(leap-backward)')
