require('flash').setup {
    -- labels = "asdfghjklqwertyuiopzxcvbnm",
    -- search = {
    --     multi_window = true,
    --     forward = true, -- when `false`, find only matches in the given direction
    --     wrap = true,
    --     mode = "exact",
    --     incremental = false, -- behave like `incsearch`
    --     exclude = { "notify", "cmp_menu", "noice", "flash_prompt", function(win) return not vim.api.nvim_win_get_config(win) .focusable end, }, -- exclude non-focusable windows
    --     trigger = "",
    --     max_length = false,
    -- },
    -- jump = {
    --     save location in the jumplist
    --     jumplist = true, -- jump position
    --     pos = "start",
    --     history = false, -- add pattern to search history
    --     register = false, -- add pattern to search register
    --     nohlsearch = false, -- clear highlight after jump
    --     autojump = false, -- automatically jump when there is only one match
    --     inclusive = nil, -- You can force inclusive/exclusive jumps by setting the `inclusive` option. By default it will be automatically set based on the mode.
    --     offset = nil, -- jump position offset. Not used for range jumps. 0: default 1: when pos == "end" and pos < current position
    -- },
    jump = {
        autojump = true,
    },
    -- label = {
    --     uppercase = true, -- allow uppercase labels
    --     exclude = "", -- add any labels with the correct case here, that you want to exclude
    --     current = true, -- add a label for the first match in the current window. you can always jump to the first match with `<CR>`
    --     after = true, -- show the label after the match
    --     before = false, -- show the label before the match
    --     style = "overlay", -- "eol" | "overlay" | "right_align" | "inline" -- position of the label extmark.
    --     reuse = "lowercase", -- "lowercase" | "all" | "none" -- flash tries to re-use labels that were already assigned to a position, when typing more characters. By default only lower-case labels are re-used. for the current window, label targets closer to the cursor first
    --     distance = true,
    --     min_pattern_length = 0, -- minimum pattern length to show labels Ignored for custom labelers.
    --     rainbow = { -- Enable this to use rainbow colors to highlight labels Can be useful for visualizing Treesitter ranges.
    --         enabled = false,
    --         shade = 5, -- number between 1 and 9
    --     },
    --     format = function(opts) return { { opts.match.label, opts.hl_group } } end, -- With `format`, you can change how the label is rendered. Should return a list of `[text, highlight]` tuples.
    -- },
    label = {
        after = false,
        before = true,
    },
    -- highlight = {
    --     backdrop = true, -- show a backdrop with hl FlashBackdrop
    --     matches = true, -- Highlight the search matches
    --     priority = 5000, -- extmark priority
    --     groups = {
    --         match = "FlashMatch",
    --         current = "FlashCurrent",
    --         backdrop = "FlashBackdrop",
    --         label = "FlashLabel",
    --     },
    -- },
    -- action = nil,     -- action to perform when picking a label. -- defaults to the jumping logic depending on the mode.
    -- pattern = "",     -- initial pattern to use when opening flash
    -- continue = false, -- When `true`, flash will try to continue the last search
    -- config = nil,     -- Set config to a function to dynamically change the config
    -- modes = { -- You can override the default options for a specific mode. Use it with `require("flash").jump({mode = "forward"})`
    --     search = { -- options used when flash is activated through a regular search with `/` or `?`
    --         enabled = false, -- when `true`, flash will be activated during regular search by default. You can always toggle when searching with `require("flash").toggle()`
    --         highlight = { backdrop = false },
    --         jump = { history = true, register = true, nohlsearch = true },
    --         search = {
    --             -- `forward` will be automatically set to the search direction
    --             -- `mode` is always set to `search`
    --             -- `incremental` is set to `true` when `incsearch` is enabled
    --         },
    --     },
    --     char = { -- options used when flash is activated through `f`, `F`, `t`, `T`, `;` and `,` motions
    --         enabled = true,
    --         config = function(opts) -- dynamic configuration for ftFT motions
    --             opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y") -- autohide flash when in operator-pending mode
    --             opts.jump_labels = opts.jump_labels -- disable jump labels when not enabled, when using a count, or when recording/executing registers
    --                 and vim.v.count == 0
    --                 and vim.fn.reg_executing() == ""
    --                 and vim.fn.reg_recording() == ""
    --
    --             -- Show jump labels only in operator-pending mode
    --             -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
    --         end,
    --         autohide = false, -- hide after jump when not using jump labels
    --         jump_labels = false, -- show jump labels
    --         multi_line = true, -- set to `false` to use the current line only
    --         label = { exclude = "hjkliardc" }, -- When using jump labels, don't use these keys This allows using those keys directly after the motion
    --         keys = { "f", "F", "t", "T", ";", "," }, -- by default all keymaps are enabled, but you can disable some of them, by removing them from the list. If you rather use another key, you can map them to something else, e.g., { [";"] = "L", [","] = H }
    --         char_actions = function(motion) --"next" | "prev" | "right" | "left" -- The direction for `prev` and `next` is determined by the motion. -- `left` and `right` are always left and right.
    --             return {
    --                 [";"] = "next", -- set to `right` to always go right
    --                 [","] = "prev", -- set to `left` to always go left
    --                 -- clever-f style
    --                 [motion:lower()] = "next",
    --                 [motion:upper()] = "prev",
    --                 -- jump2d style: same case goes next, opposite case goes prev
    --                 -- [motion] = "next",
    --                 -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
    --             }
    --         end,
    --         search = { wrap = false },
    --         highlight = { backdrop = true },
    --         jump = {
    --             register = false,
    --             autojump = false, -- when using jump labels, set to 'true' to automatically jump or execute a motion when there is only one match
    --         },
    --     },
    --     treesitter = { -- options used for treesitter selections `require("flash").treesitter()`
    --         labels = "abcdefghijklmnopqrstuvwxyz",
    --         jump = { pos = "range", autojump = true },
    --         search = { incremental = false },
    --         label = { before = true, after = true, style = "inline" },
    --         highlight = {
    --             backdrop = false,
    --             matches = false,
    --         },
    --     },
    --     treesitter_search = {
    --         jump = { pos = "range" },
    --         search = { multi_window = true, wrap = true, incremental = false },
    --         remote_op = { restore = true },
    --         label = { before = true, after = true, style = "inline" },
    --     },
    --     remote = { remote_op = { restore = true, motion = true }, }, -- options used for remote flash
    -- },
    modes = {
        char = {
            enabled = false,
        },
    },
    -- prompt = { -- options for the floating window that shows the prompt, for regular jumps `require("flash").prompt()` is always available to get the prompt text
    --     enabled = true,
    --     prefix = { { "⚡", "FlashPromptIcon" } },
    --     win_config = {
    --         relative = "editor",
    --         border = "none",
    --         width = 1, -- when <=1 it's a percentage of the editor width
    --         height = 1,
    --         row = -1, -- when negative it's an offset from the bottom
    --         col = 0, -- when negative it's an offset from the right
    --         zindex = 1000,
    --     },
    -- },
    prompt = {
        -- enabled = true,
        prefix = { { "> ", "FlashPromptIcon" } },
        -- prefix = { { "[FLASH] ", "Title" } },
        win_config = {
            relative = "editor",
            width = 70, -- when <=1 it's a percentage of the editor width
            height = 1,
            row = -1,   -- when negative it's an offset from the bottom
            col = 0,    -- when negative it's an offset from the right
            zindex = 1000,
        },
    },
    -- remote_op = { -- options for remote operator pending mode
    --   restore = false, -- restore window views and cursor position after doing a remote operation
    --   -- For `jump.pos = "range"`, this setting is ignored.
    --   -- `true`: always enter a new motion when doing a remote operation
    --   -- `false`: use the window's cursor position and jump target
    --   -- `nil`: act as `true` for remote windows, `false` for the current window
    --   motion = false,
    -- },
    -- options for the floating window that shows the prompt,
    -- for regular jumps
    -- `require("flash").prompt()` is always available to get the prompt text
    -- options for remote operator pending mode
}

vim.keymap.set({ 'n', 'x' }, ',', function() require("flash").jump() end)
vim.keymap.set('o', ',', function() require("flash").remote() end)

vim.keymap.set({ "n", "x", "o" }, "<F5>", function()
    require("flash").treesitter({
        actions = {
            ["]"] = "next",
            ["<F5>"] = "next",
            ["["] = "prev"
        }
    })
end, { desc = "Treesitter incremental selection" })


vim.keymap.set('n', '<leader>,s', function()
    require("flash").jump({
        pattern = vim.fn.expand("<cword>"),
    })
end)

vim.keymap.set('n', '<leader>,d', function()
    require("flash").jump({
        ---@param win number
        matcher = function(win)
            ---@param diag vim.Diagnostic
            return vim.tbl_map(function(diag)
                return {
                    pos = { diag.lnum + 1, diag.col },
                    end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                }
            end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
        end,
        action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                vim.diagnostic.open_float()
            end)
            state:restore()
        end,
    })
end)
