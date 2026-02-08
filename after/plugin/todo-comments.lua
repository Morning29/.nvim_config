require("todo-comments").setup({
    signs = false, -- show icons in the signs column
    colors = {
        todo = { "Todo", "#ff00ff" },
        error = { "DiagnosticError", "ErrorMsg", "#ff00ff" },
        warning = { "DiagnosticWarn", "WarningMsg", "#ff00ff" },
        info = { "DiagnosticInfo", "#ff00ff" },
        hint = { "#749cae", "#ff00ff" },
        notif = { "Question", "#ff00ff" },
        default = { "Identifier", "#ff00ff" },
    },
    keywords = {
        NOCOMMIT = { icon = "  ", color = "error", alt = { "NOCOMMIT", "NOCHECKIN" } },
        FIX = { icon = "  ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        WARN = { icon = "  ", color = "warning", alt = { "WARNING", "XXX" } },
        TODO = { icon = "  ", color = "todo" },
        HACK = { icon = "  ", color = "notif" },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        PERF = { icon = " ", color = "notif", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        RESUME = { icon = " ", color = "notif" },
    },
    highlight = {
        multiline = false,        -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,   -- extra lines that will be re-evaluated when changing a line
        before = "",              -- "fg" or "bg" or empty
        keyword = "fg",           -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "",               -- "fg" or "bg" or empty
        --     pattern = [[.*<(KEYWORDS)\s*:]],
        --     -- pattern = [[.*<((KEYWORDS)(:|\s+[0-9]|\s*\(.*\)))]],
        pattern = [[.*<((KEYWORDS)(:|(\s((:|[0-9]*/*)*\sHSU:)|\s)))]],
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400,   -- ignore lines longer than this
        exclude = {},         -- list of file types to exclude highlighting
    },
})
