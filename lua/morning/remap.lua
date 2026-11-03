vim.g.mapleader = " "

local stay_in_place = function(cmd_str)
    return "mz" .. cmd_str .. "`z"
end

do
    -------------
    -- General --
    -------------

    -- <C-h> != backspace.
    vim.keymap.set({ "n", "i", "v" }, "<C-h>", "<nop>")

    -- Escape from terminal mode.
    vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })

    -- Clear search
    vim.keymap.set("i", "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true })

    -- Put the good jump to mark on the easy-to-reach key and the useless one on the carpal-tunnel-syndrome-ass key.
    vim.keymap.set({ "n", "v" }, "'", "`", { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "`", "'", { noremap = true, silent = true })

    -- IJKL
    vim.keymap.set("", "i", "k", { noremap = true, silent = true })
    vim.keymap.set("", "j", "h", { noremap = true, silent = true })
    vim.keymap.set("", "k", "j", { noremap = true, silent = true })
    vim.keymap.set("", "h", "i", { noremap = true, silent = true })

    -- Use <C-t> for jump list instead of tag stack.
    vim.keymap.set("n", "<C-n>", "<C-i>", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-t>", "<C-o>", { noremap = true, silent = true })

    -- Jump to tags without going through the prompt.
    vim.keymap.set("n", "<C-]>", "g<C-]>", { noremap = true, silent = true })

    -- Jump to previous buffer.
    vim.keymap.set("n", "<leader><C-t>", ":b#<cr>", { noremap = true, silent = true })

    -- https://github.com/tpope/vim-fugitive/issues/1425#issuecomment-995106715
    -- tpope plugins use 'h' in place of 'i'.
    vim.g.nremap = { i = "h" }
    vim.g.xremap = { i = "h" }
    vim.g.oremap = { i = "h" }

    -- Move to window using <C-[ijkl]>.
    vim.keymap.set("n", "<C-J>", "<C-W>h", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = true, silent = true })
    -- NOTE: Configure terminal to send <F14> on ctrl+i...
    vim.keymap.set("n", "<F14>", "<C-W>k", { noremap = true, silent = true })
    vim.keymap.set("n", "<C-K>", "<C-W>j", { noremap = true, silent = true })

    -- Stay in place when using J.
    vim.keymap.set("n", "J", stay_in_place("J"), { noremap = true, silent = true })

    -- Equalize window sizes.
    vim.keymap.set("n", "<leader>0", "<C-w>=", {})

    -- Quick fix.
    vim.keymap.set("n", "<F3>", "<cmd>cwindow<cr><cmd>crewind<cr>")
    vim.keymap.set("n", "<F4>", "<cmd>cwindow<cr><cmd>cnext<cr>")

    -- Search/replace word under cursor.
    vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left><Space><Backspace>]])

    -- vim-easy-align
    vim.keymap.set({ "n", "x" }, "<leader>a", "<Plug>(EasyAlign)")
end

do
    -----------------
    -- Multicursor --
    -----------------

    local nvim_version = vim.version()
    if nvim_version.major < 1 and nvim_version.minor < 13 then
        vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })
    else --- @format disable
        local clear_cursors_cmd =
        [[<Cmd>nohlsearch|diffupdate|call nvim_buf_clear_namespace(0, nvim_create_namespace("nvim.multicursor"), 0, -1)|normal! <C-L><CR>]]

        vim.keymap.set({ "n", "x" }, "<leader><C-Q>", clear_cursors_cmd, { noremap = true,  silent = true })
        vim.keymap.set({ "n", "x" }, "<C-Q>",         "Q",               { noremap = true,  silent = true })
        vim.keymap.set({ "n",     }, "<leader>qq",    "zq",              { noremap = true,  silent = true })
        vim.keymap.set({ "x",     }, "<leader>qq",    "zq",              { noremap = true,  silent = true })
        vim.keymap.set({ "n", "x" }, "<leader>qr",    "gQ",              { noremap = false, silent = true })
        vim.keymap.set({ "n", "x" }, "<leader><C-a>", "g<C-a>",          { noremap = true,  silent = true })
    end
end

do --- @format disable
    -----------------
    -- Up and Down --
    -----------------

    local ins_move_up = "<esc><cmd>m .-2<cr>==gi"

    vim.keymap.set("n", "<M-i>", "<cmd>m .-2<cr>==",        { desc = "Move up"   })
    vim.keymap.set("n", "<M-k>", "<cmd>m .+1<cr>==",        { desc = "Move down" })

    vim.keymap.set("i", "<M-i>", ins_move_up,               { desc = "Move up"   })
    vim.keymap.set("i", "<M-k>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })

    vim.keymap.set("v", "<M-k>", ":m '>+1<cr>gv=gv",        { desc = "Move down" })
    vim.keymap.set("v", "<M-i>", ":m '<-2<cr>gv=gv",        { desc = "Move up"   })

    local fo_rem = function(fo, cmd) return "<cmd>set formatoptions-=" .. fo .. "<cr>" .. cmd end
    local fo_add = function(fo, cmd) return "<cmd>set formatoptions+=" .. fo .. "<cr>" .. cmd .. fo_rem(fo, "") end

    -- NOTE: Configure terminal to send <F15> on ctrl+enter, <C-F15> on shift+ctrl+enter, and <F17> on ctrl+shift+o.
    vim.keymap.set("n", "o",       fo_rem("o", "o"),                 { noremap = true, silent = true })
    vim.keymap.set("n", "O",       fo_rem("o", "O"),                 { noremap = true, silent = true })
    vim.keymap.set("n", "<C-o>",   fo_add("o", "o"),                 { noremap = true, silent = true })
    vim.keymap.set("n", "<F17>",   fo_add("o", "O"),                 { noremap = true, silent = true })
    vim.keymap.set("i", "<CR>",    fo_rem("r", "<CR>"),              { noremap = true, silent = true })
    vim.keymap.set("i", "<S-CR>",  fo_rem("r", "<CR>"..ins_move_up), { noremap = true, silent = true })
    vim.keymap.set("i", "<F15>",   fo_add("r", "<CR>"),              { noremap = true, silent = true })
    vim.keymap.set("i", "<C-F15>", fo_add("r", "<CR>"..ins_move_up), { noremap = true, silent = true })
end

do
    ----------------------------
    -- Inner node text object --
    ----------------------------

    vim.keymap.set({ "x", "o" }, "in", "<nop>")
    vim.keymap.del({ "x", "o" }, "in")
    vim.keymap.set({ "x", "o" }, "hn",
        function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
                require("vim.treesitter._select").select_child(vim.v.count1)
            else
                vim.lsp.buf.selection_range(-vim.v.count1)
            end
        end,
        { desc = "Select child (inner) node" }
    )
end

do
    ---------------
    -- Registers --
    ---------------

    vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "D", '"_D', { noremap = true, silent = true })
    vim.keymap.set({ "n", }, "dd", '"_dd', { noremap = true, silent = true })

    vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "C", '"_C', { noremap = true, silent = true })
    vim.keymap.set({ "n", }, "cc", '"_cc', { noremap = true, silent = true })

    vim.keymap.set({ "n", }, "s", '"_s', { noremap = true, silent = true })
    vim.keymap.set({ "n", }, "S", '"_S', { noremap = true, silent = true })

    vim.keymap.set({ "x", }, "p", '"_dP', { noremap = true, silent = true })

    -- Yank to/paste from selection (system clipboard) register.
    vim.keymap.set({ "n", "i", "x" }, "<M-y>", '"*y', { noremap = true, silent = true })
    vim.keymap.set({ "n", "i", "x" }, "<M-p>", '"*p', { noremap = true, silent = true })

    -- Cut to yank register.
    vim.keymap.set({ "n", "v" }, "x", '"+d', { noremap = true, silent = true })
    vim.keymap.set({ "n", "v" }, "X", '"+D', { noremap = true, silent = true })
    vim.keymap.set({ "n", }, "xx", '"+dd', { noremap = true, silent = true })
end

do
    -------------------
    -- Convert cases --
    -------------------

    -- PascalCase/camelCase -> snake_case:
    -- IWishThisPascalCaseWasSnakeCase -> i_wish_this_pascal_case_was_snake_case
    -- ALSOWorksWITHFullyCAPITALIZEDParts -> also_works_with_fully_capitalized_parts
    -- TODO 02/10/26 HSU: This is not correct....
    local pascal_to_snake = [[:s/\v%V\l(\zs\u)|%V(\u\ze)\l|%V(\u)/\=tolower(submatch(3) ?? '_'.submatch(0))/g]]
    vim.keymap.set("v", "<leader>cts", stay_in_place(pascal_to_snake .. "<CR>"))
    vim.keymap.set("n", "<leader>cts", stay_in_place("viw" .. pascal_to_snake .. "<CR>"))

    -- snake_case -> Ada_Case
    local snake_to_ada = [[:s/\v%V<\l\ze|%V_\l/\=toupper(submatch(0))/g]]
    vim.keymap.set("v", "<leader>cta", stay_in_place(snake_to_ada .. "<CR>"))
    vim.keymap.set("n", "<leader>cta", stay_in_place("viw" .. snake_to_ada .. "<CR>"))

    -- snake_case -> PascalCase
    local snake_to_pascal = [[:s/\v%V<\l\ze|%V_\l/\=trim(toupper(submatch(0)), "_")/g]]
    vim.keymap.set("v", "<leader>ctp", stay_in_place(snake_to_pascal .. "<CR>"))
    vim.keymap.set("n", "<leader>ctp", stay_in_place("viw" .. snake_to_pascal .. "<CR>"))
end

do
    --------------
    -- Building --
    --------------

    vim.keymap.set("n", "<leader>mm", "<cmd>make<cr>")
    -- TODO 07/05/26 HSU: Make these local to vk_odin/projects containing such files.
    vim.keymap.set("n", "<leader>mss", [[:w | :!pwsh.exe compile_shaders.ps1 -all %<CR>]])
    vim.keymap.set("n", "<leader>msS", [[:w | :!pwsh.exe compile_shaders.ps1 %<CR>]])

    vim.keymap.set("n", "<leader>mso", [[:w | :!pwsh.exe compile_shaders.ps1 -opt -all %<CR>]])
    vim.keymap.set("n", "<leader>msO", [[:w | :!pwsh.exe compile_shaders.ps1 -opt %<CR>]])

    -- TODO 03/11/26 HSU: Make this an odin filetype autocmd.
    local build_script_name = [[.\build_ui_lib.bat]]
    local build_cmd = [[:w | :!]] .. build_script_name

    vim.keymap.set("n", "<leader>muu", build_cmd .. [[ debug]] .. [[<CR>]])
    vim.keymap.set("n", "<leader>muo", build_cmd .. [[ release]] .. [[<CR>]])
end

do
    -----------------------
    -- Comment-yank-dupe --
    -----------------------

    local hl_yank_timeout = 500
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
        callback = function(_)
            vim.hl.hl_op({ higroup = "Visual", timeout = 500 })
        end,
    })

    local comment_yank_ns = vim.api.nvim_create_namespace("nvim.hlyank")

    ---@param yank boolean
    ---@param duplicate boolean
    ---@param single boolean
    local cmt_yank_dupe = function(yank, duplicate, single)
        ---@param mode string?
        ---|"'line'"
        ---|"'char'"
        ---|"'block'"
        _G.cmt_yank_dupe_operator = function(mode)
            if mode == nil then
                vim.o.operatorfunc = "v:lua.cmt_yank_dupe_operator"
                return "g@"
            end

            local mark_from, mark_to = "'[", "']"
            local lnum_from, col_from = vim.fn.line(mark_from), vim.fn.col(mark_from)
            local lnum_to, col_to = vim.fn.line(mark_to), vim.fn.col(mark_to)

            local empty_text_object = (lnum_from > lnum_to) or (lnum_from == lnum_to and col_from > col_to)
            if empty_text_object then
                return false
            end

            local cursor = vim.api.nvim_win_get_cursor(0)

            local lines
            if duplicate then
                lines = vim.api.nvim_buf_get_lines(0, lnum_from - 1, lnum_to, false)
            end

            if yank then
                vim.cmd(":" .. lnum_from .. "," .. lnum_to .. "y")
            end

            require("vim._comment").toggle_lines(lnum_from, lnum_to, cursor)

            if duplicate then
                vim.api.nvim_buf_set_lines(0, lnum_from - 1, lnum_from - 1, false, lines)
            end

            vim.hl.range(0, comment_yank_ns, "Visual", { lnum_from - 1, 0 }, { lnum_to, 0 },
                { timeout = hl_yank_timeout })
            vim.api.nvim_win_set_cursor(0, cursor)

            _G.cmt_yank_dupe_operator = nil

            return ""
        end

        return _G.cmt_yank_dupe_operator() .. (single and "_" or "")
    end

    ---@format disable
    vim.keymap.set({ "n", "x" }, "gyc",  function() return cmt_yank_dupe(true,  false, false) end, { expr = true })
    vim.keymap.set({ "n",     }, "gycc", function() return cmt_yank_dupe(true,  false, true)  end, { expr = true })
    vim.keymap.set({ "n", "x" }, "gdc",  function() return cmt_yank_dupe(false, true,  false) end, { expr = true })
    vim.keymap.set({ "n",     }, "gdcc", function() return cmt_yank_dupe(false, true,  true)  end, { expr = true })
end
