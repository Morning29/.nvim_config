require("todo-comments").setup({
    signs = false, -- show icons in the signs column
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
        RESUME = { icon = " ", color = "error" },
    },
    highlight = {
        -- pattern = [[.*<(KEYWORDS)\s*:]],
        pattern = [[.*<((KEYWORDS)(:|\s+[0-9]))]],
        multiline = true, -- enable multine todo comments
        before = "",      -- "fg" or "bg" or empty
        keyword = "fg",   -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",     -- "fg" or "bg" or empty
    },
})
