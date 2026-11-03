require('nvim-surround').setup({
    -- keymaps = {
    --     -- insert = "<C-g>s",
    --     -- insert_line = "<C-g>S",
    --     -- normal = "ys",
    --     -- normal_cur = "yss",
    --     -- normal_line = "yS",
    --     -- normal_cur_line = "ySS",
    --     -- visual = "S",
    --     -- visual_line = "gS",
    --     -- delete = "ds",
    --     -- change = "cs",
    --     -- change_line = "cS",
    -- },
    aliases = {
        ["p"] = ")",
        ["<C-p>"] = ")",
        ["<C-8>"] = ")",
        ["<F16>"] = "}",
        ["<C-]>"] = "]",
        ["<C-.>"] = ">",
    },
})

vim.keymap.set("i", "<F16>", "<Plug>(nvim-surround-insert-line)", {
    desc = "Add a surrounding pair around the cursor, on new lines (insert mode)",
})
