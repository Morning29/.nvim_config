if true then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

-- local root_dir = { Util.lualine.root_dir() }
-- local pretty_path = { Util.lualine.pretty_path() }

local diagnostics = {
    "diagnostics",
    -- sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    -- symbols = { error = " ", warn = " " },
    -- symbols = { error = "E", warn = "W", info = "I", hint = "H"  },
    symbols = { error = "", warn = "", info = "", hint = "" },
    colored = true,
    update_in_insert = false,
    always_visible = false,
    padding = 1,
}

local signcol = {
    "mode",
    fmt = function(_)
        return "  "
    end,
    color = "SignColumn",
    padding = 1,
}

local mode = {
    "mode",
    -- fmt = function(str)
    --   return str .. " "
    -- end,
    padding = 1,
    cond = function()
        return vim.fn.mode() ~= "c"
    end,
}

local command_mode = {
    "mode",
    cond = function()
        return vim.fn.mode() == "c"
    end,
    padding = { left = 1, right = 0 },
}

local recording_macro = {
    function() return "recording @" .. vim.fn.reg_recording() end,
    cond = function() return vim.fn.reg_recording() ~= "" end,
    color = { fg = "#242424", bg = "#ff9e64" }, --  fg = "#ff9e64" }, -- TODO: get from colorscheme (c.fg_editor)
    padding = 1
}

local mode_inactive = function()
    return " "
end

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local diff = {
    "diff",
    colored = true,
    symbols = { added = "+", modified = "*", removed = "-" },
    -- cond = hide_in_width,
    padding = 1,
    separator = "|",
}

local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
    padding = 1,
    -- separator = "|",
}

local filename = {
    "filename",
    padding = 1,
    separator = "|",
}

local location = {
    "location",
    padding = 1,
    -- separator = "|",
}

local progress = {
    "progress",
    padding = 1,
    separator = "|",
}

local encoding = {
    "encoding",
    padding = 1,
    separator = "|",
}

local fileformat = {
    "fileformat",
    icons_enabled = false,
    padding = 1,
    separator = "|",
}

local get_progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
    local line_ratio = current_line / total_lines
    local index = 1 + #chars - math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    return "␣ " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local colors = { -- TODO: Put this in the colorscheme and require() it here
    white = "#ffffff",
    darkestgreen = "#005f00",
    brightgreen = "#a6c43d",
    darkestcyan = "#005f5f",
    mediumcyan = "#87dfff",
    darkestblue = "#005f87",
    darkred = "#870000",      -- visual mode fg
    brightred = "#df0000",
    brightorange = "#fcd3af", --"#d09b6e", -- '#ff8700', -- visual mode bg
    gray0 = "#262626",
    gray1 = "#242424",        -- editor bg
    gray2 = "#303030",        -- lualine bg dark
    gray4 = "#404040",
    gray5 = "#505050",        -- lualine bg bright
    gray7 = "#9e9e9e",
    gray10 = "#cccccc",
}

local simplerdarcula = {
    normal = {
        -- a = { fg = colors.gray1, bg = colors.brightgreen, gui = "bold" },
        a = { fg = colors.gray10, bg = colors.gray4, gui = "bold" },
        b = { fg = colors.gray10, bg = colors.gray4 },
        c = { fg = colors.gray7, bg = colors.gray2 },
        --
        y = { fg = colors.gray7, bg = colors.gray4 },
        z = { fg = colors.gray4, bg = colors.gray7 },
    },
    insert = {
        -- a = { fg = colors.gray10, bg = colors.darkestblue, gui = "bold" },
        a = { fg = colors.gray10, bg = colors.gray4, gui = "bold" },
        z = { fg = colors.gray4, bg = colors.gray7 },
    },
    command = {
        a = { fg = colors.gray10, bg = colors.gray4, gui = "bold" },
        z = { fg = colors.gray4, bg = colors.gray7 },
    },
    visual = {
        a = { fg = colors.gray0, bg = colors.brightorange, gui = "bold" },
        z = { fg = colors.gray4, bg = colors.gray7 },
    },
    replace = {
        a = { fg = colors.white, bg = colors.brightred, gui = "bold" },
        z = { fg = colors.gray4, bg = colors.gray7 },
    },
    inactive = {
        a = { fg = colors.gray2, bg = colors.gray5 },
        b = { fg = colors.gray4, bg = colors.gray0 },
        c = { fg = colors.gray5, bg = colors.gray2 },
    },
}

require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = simplerdarcula,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "Outline" },
        always_divide_middle = true,
        padding = 0,
    },
    sections = {
        lualine_a = { mode, command_mode },
        lualine_b = { filename,
            -- { highlighted_cwd_and_current_file, padding = 1 },
            -- filename,
            --
            -- root_dir(),
            -- { Util.lualine.pretty_path(), padding = { right = 1 } },
            branch,
        },
        lualine_c = {
            diagnostics,
        },
        -- lualine_c = { root_dir },
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_x = {
            recording_macro,
        },
        lualine_y = {
            fileformat,
            encoding,
            filetype,
        },
        lualine_z = { progress, location },
    },
    inactive_sections = {
        --[[ lualine_a = { mode_inactive }, ]]
        lualine_a = {},
        lualine_b = { filename },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { progress },
        lualine_z = { location },
    },
    tabline = {},
    extensions = {},
})
