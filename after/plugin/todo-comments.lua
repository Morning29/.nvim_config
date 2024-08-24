require("todo-comments").setup({
    signs = false,         -- show icons in the signs column
    colors = {
        todo = { "Todo", "#ff00ff" },
        error = { "DiagnosticError", "ErrorMsg", "#ff00ff" },
        warning = { "DiagnosticWarn", "WarningMsg", "#ff00ff" },
        info = { "DiagnosticInfo", "#ff00ff" },
        hint = { "DiagnosticHint", "#ff00ff" },
        default = { "Identifier", "#ff00ff" },
    },
    keywords = {
        FIX = { icon = "  ", color = "warning", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        WARN = { icon = "  ", color = "warning", alt = { "WARNING", "XXX" } },
        TODO = { icon = "  ", color = "todo" },
        HACK = { icon = "  ", color = "todo" },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    },
    highlight = {
        multiline = true,         -- enable multine todo comments
        -- multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        -- multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "",            -- "fg" or "bg" or empty
        keyword = "fg",         -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",           -- "fg" or "bg" or empty
        -- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        -- comments_only = true, -- uses treesitter to match keywords in comments only
        -- max_line_len = 400, -- ignore lines longer than this
        -- exclude = {}, -- list of file types to exclude highlighting
    },
    -- --     gui_style = {
    -- --         fg = "NONE", -- The gui style to use for the fg highlight group.
    -- --         bg = "BOLD", -- The gui style to use for the bg highlight group.
    -- --     },
    -- --     merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- --     -- highlighting of the line containing the todo comment
    -- --     -- * before: highlights before the keyword (typically comment characters)
    -- --     -- * keyword: highlights of the keyword
    -- --     -- * after: highlights after the keyword (todo text)
    -- --     -- list of named colors where we try to extract the guifg from the
    -- --     -- list of highlight groups or use the hex color if hl not found as a fallback
    -- --     search = {
    -- --         command = "rg",
    -- --         args = {
    -- --             "--color=never",
    -- --             "--no-heading",
    -- --             "--with-filename",
    -- --             "--line-number",
    -- --             "--column",
    -- --         },
    -- --         -- regex that will be used to match keywords.
    -- --         -- don't replace the (KEYWORDS) placeholder
    -- --         pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- --         -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    -- --     },
})
