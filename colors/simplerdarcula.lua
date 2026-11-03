-- TODO 11/05/26 HSU: Light theme.

vim.g.colors_name = 'simplerdarcula'

do
    local fg_normal = "#e0e2ea"
    local c = {
        NONE            = "none",

        fg_normal       = fg_normal,
        fg_normal_sbar  = "#747474", -- "#707070",
        fg_float_sbar   = "#747474", -- "#707070",
        fg_punctuation  = fg_normal, -- "#b4b4b4", -- "#b0b0b0",
        fg_string       = "#91b3d8",
        fg_number       = "#FFFFFF",
        fg_type         = "#b4b4b4", -- "#b0b0b0",
        fg_builtintype  = "#fcd3af",
        fg_special      = "#fcd3af",
        fg_operator     = fg_normal,
        fg_border       = "#343434", -- "#303030", -- buffer separator
        fg_comment      = "#747474", -- "#707070",
        fg_keyword      = "#fcd3af",
        fg_keyword_dim  = "#907964",
        fg_cursorlinenr = "#747474", -- "#707070", -- cursorlinenr
        fg_whitespace   = "#343434", -- "#303030", -- cursorlinenr
        fg_gutter       = "#4b4b4b", -- "#474747", -- line number
        fg_sidebar      = "#ff00ff",
        fg_variable     = "#e0e2ea",
        fg_function     = "#d09b6e", -- "#996c46",
        fg_field        = fg_normal, -- "#d09b6e", -- fields used to be orange?
        fg_macro        = "#907964",
        fg_statement    = "#fcd3af", -- statement, identifier,
        fg_identifier   = fg_normal, -- statement, identifier,
        fg_todo         = "#a6c43d",
        fg_unused       = "#747474", -- "#747474", -- unused function, unused variable
        fg_constant     = fg_normal, -- number (remap), boolean, matched brace (remap), constant
        fg_editor       = "#ff9e64",
        fg_editor_dim   = "#915a39",
        fg_motion_label = "#dd0070", -- "#dd0070",

        bg_faint        = "#2c2c2c", -- "#282828",
        bg_light        = "#343434", -- "#303030",
        bg_dark         = "#262626", -- "#222222",
        bg_border       = "#242424", -- "#202020",
        bg_normal       = "#282828", -- "#242424", -- TODO: if using light theme then light and vice versa
        bg_normal_sbar  = "#343434", -- "#303030", -- TODO: if using light theme then light and vice versa
        bg_float        = "#464646", -- "#424242", -- TODO: if using light theme then dark and vice versa
        bg_float_sbar   = "#4a4a4a", -- "#464646", -- TODO: if using light theme then dark and vice versa
        bg_cursorline   = "#2f2f2f", -- "#2b2b2b",
        bg_visual       = "#4c3a27", -- "#42372C",
        bg_visual_nos   = "#592b3c", -- "#42372c",
        bg_search       = "#2d4c9d", -- "#2d4c9d",
        bg_incsearch    = "#2e58c1", -- "#2e58c1",
        bg_cursearch    = "#0B4966", -- "#11709b",
        bg_sidebar      = "#282828", -- "#242424",
        bg_statusline   = "#343434", -- "#303030",

        diag            = {
            fg_error             = "#e26a75",
            fg_warning           = "#ffc739",
            fg_info              = "#d0d0d0",
            fg_hint              = "#44798A", -- "#405055",
            fg_ok                = "#b8db87",
            fg_unnecessary       = "#707070",

            fg_vtext_error       = "#893038",
            fg_vtext_warning     = "#463B12",
            fg_vtext_info        = "#404040",
            fg_vtext_hint        = "#404040",
            fg_vtext_ok          = "#455430",

            fg_vtext_unnecessary = "#707070",
            sp_deprecated        = "#ffc739",
        },

        diff            = {
            add           = "#b8db87",
            change        = "#7ca1f2",
            delete        = "#e26a75",
            ignore        = "#ffc739",
            text          = "#545c7e",
            add_gutter    = "#384C38",
            change_gutter = "#374752",
            delete_gutter = "#656E76",
        },
    }

    -- fg:                    color name or "#RRGGBB", see note.
    -- fg_indexed:    boolean (default false) If true, fg is a terminal palette index (0-255).
    -- bg:                    color name or "#RRGGBB", see note.
    -- bg_indexed:    boolean (default false) If true, bg is a terminal palette index (0-255).
    -- blend:                 integer between 0 and 100
    -- cterm:                 cterm attribute map, like `highlight-args`. If not set, cterm attributes will match those from the attribute map documented above.
    -- ctermbg:               Sets background of cterm color `ctermbg`
    -- ctermfg:               Sets foreground of cterm color `ctermfg`
    -- default:       boolean Dont override existing definition `:hi-default`
    -- force:                 if true force update the highlight group when it exists.
    -- link:                  Name of highlight group to link to. `:hi-link`
    -- sp:                    color name or "#RRGGBB"
    -- altfont:       boolean
    -- blink:         boolean
    -- bold:          boolean
    -- conceal:       boolean Concealment at the UI level (terminal SGR), unrelated to `:syn-conceal`.
    -- dim:           boolean
    -- italic:        boolean
    -- nocombine:     boolean
    -- overline:      boolean
    -- reverse:       boolean
    -- standout:      boolean
    -- strikethrough: boolean
    -- undercurl:     boolean
    -- underdashed:   boolean
    -- underdotted:   boolean
    -- underdouble:   boolean
    -- underline:     boolean

    local default_groups = {
        custom = {
            Italic = { italic = true },
            Blink = { fg = c.fg_editor, blink = true }
        },
        builtin = {
            Normal                     = { fg = c.fg_normal, bg = c.bg_normal },
            NormalNC                   = { link = "Normal" },
            EndOfBuffer                = { link = "Normal" },
            NormalFloat                = { bg = c.bg_float },
            FloatTitle                 = { fg = c.fg_normal, bg = c.bg_float, bold = true },
            FloatBorder                = { link = "NormalFloat" },
            Pmenu                      = { bg = c.bg_float },
            PmenuSel                   = { bg = c.bg_search },
            PmenuSbar                  = { bg = c.bg_float_sbar },
            PmenuThumb                 = { bg = c.fg_float_sbar },
            MoreMsg                    = { fg = c.fg_editor },
            Visual                     = { bg = c.bg_visual },
            VisualNOS                  = { bg = c.bg_visual_nos },
            Search                     = { bg = c.bg_search },
            CurSearch                  = { bg = c.bg_cursearch, bold = true },
            IncSearch                  = { bg = c.bg_incsearch, bold = true },
            MatchParen                 = { bg = c.bg_incsearch },
            Cursor                     = { fg = c.bg_normal, bg = c.fg_normal, reverse = false, nocombine = true },
            -- MCursor                    = { fg = c.none, bg = c.none, reverse = false },
            -- MCursorVisual              = { fg = c.none, bg = c.none, reverse = false },
            MCursor                    = { fg = c.bg_normal, bg = c.fg_editor, reverse = false },
            MCursorVisual              = { fg = c.bg_normal, bg = c.fg_editor, reverse = false },
            CursorLine                 = { bg = c.bg_cursorline },
            CursorLineNr               = { fg = c.fg_cursorlinenr },
            LineNr                     = { fg = c.fg_gutter },
            LineNrAbove                = { link = "LineNr" },
            LineNrBelow                = { link = "LineNr" },
            WinSeparator               = { fg = c.fg_border },
            StatusLine                 = { bg = c.bg_statusline, italic = false, bold = true, nocombine = true },
            StatusLineNC               = { bg = c.bg_statusline, italic = true, bold = false, nocombine = true },
            WinBar                     = { link = "StatusLine" },
            WinBarNC                   = { link = "StatusLineNC" },
            Title                      = { fg = c.fg_editor, bold = true },
            Bold                       = { bold = true },
            Conceal                    = { link = "Comment" },
            Whitespace                 = { fg = c.fg_whitespace },
            SpecialKey                 = { fg = c.fg_editor },
            NonText                    = { link = "Comment" },
            Directory                  = { link = "Comment" }, -- "guifg=", "links to" etc when displaying :hi
            Underlined                 = { fg = c.fg_string, sp = c.fg_string, underline = true },
            Substitute                 = { bg = c.bg_search }, -- flash letters
            QuickFixLine               = { bg = c.bg_float, sp = c.fg_function, bold = true },
            PreProc                    = { fg = c.fg_editor },
            Comment                    = { fg = c.fg_comment },
            Todo                       = { fg = c.fg_todo },
            Delimiter                  = { fg = c.fg_punctuation },
            Special                    = { fg = c.fg_special },
            -- MsgArea                    = { link = "Normal" },
            MsgArea                    = { bg = c.bg_light },
            SignColumn                 = { bg = c.bg_normal },
            CursorLineSign             = { link = "CursorLineNr" },
            ModeMsg                    = { link = "MsgArea" },
            MsgSeparator               = { link = "WinSeparator" },
            Question                   = { link = "SpecialKey" },
            --
            TabLineSel                 = { bold = true }, -- Currently selected tab, the bg defines the line that marks the active tab.
            TabLine                    = { bg = c.bg_light },
            TabLineFill                = { bg = c.bg_light },
            --
            Type                       = { fg = c.fg_type },
            BuiltinType                = { fg = c.fg_builtintype },
            Boolean                    = { link = "BuiltinType" },
            Float                      = { link = "BuiltinType" },
            Structure                  = { link = "Type" },
            String                     = { fg = c.fg_string },
            Character                  = { link = "String" },
            Number                     = { fg = c.fg_number },
            Variable                   = { fg = c.fg_variable },
            GlobalVariable             = { fg = c.fg_constant, italic = true },
            Constant                   = { fg = c.fg_constant },
            Include                    = { fg = c.fg_keyword },
            Define                     = { fg = c.fg_keyword },
            StorageClass               = { fg = c.fg_normal },
            Macro                      = { fg = c.fg_macro },
            PreCondit                  = { link = "Keyword" },
            Tag                        = { link = "Underlined" },
            Typedef                    = { link = "Type" },
            Exception                  = { link = "Error" },
            --
            cDefine                    = { fg = c.fg_keyword },
            cTypedef                   = { fg = c.fg_keyword },
            cppType                    = { link = "BuiltinType" },
            cType                      = { link = "BuiltinType" },
            --
            Function                   = { fg = c.fg_function },
            Identifier                 = { fg = c.fg_identifier },
            Field                      = { fg = c.fg_field },
            Property                   = { link = "Field" },
            Conditional                = { fg = c.fg_keyword },
            Statement                  = { fg = c.fg_statement },
            Operator                   = { fg = c.fg_operator },
            Keyword                    = { fg = c.fg_keyword },
            Repeat                     = { link = "Keyword" },              -- Loops etc.
            Label                      = { fg = c.fg_number, bold = true }, -- underdashed, underdotted, standout,
            SpecialChar                = { link = "Keyword" },              -- String escape etc.
            --
            Spellbad                   = { undercurl = true, sp = c.diag.fg_error },
            SpellCap                   = { undercurl = true, sp = c.diag.fg_warning },
            SpellLocal                 = { undercurl = true, sp = c.diag.fg_hint },
            SpellRare                  = { undercurl = true, sp = c.diag.fg_hint },
            --
            DiffAdd                    = { fg = c.diff.add },
            DiffChange                 = { fg = c.diff.change },
            DiffDelete                 = { fg = c.diff.delete },
            DiffText                   = { fg = c.diff.text },
            DiffTextAdd                = { link = "DiffText" },
            --
            Error                      = { fg = c.diag.fg_error },
            ErrorMsg                   = { fg = c.diag.fg_error },
            WarningMsg                 = { fg = c.diag.fg_warning },
            --
            DiagnosticError            = { fg = c.diag.fg_error },
            DiagnosticWarn             = { fg = c.diag.fg_warning },
            DiagnosticInfo             = { fg = c.diag.fg_info },
            DiagnosticHint             = { fg = c.diag.fg_hint, italic = true },
            DiagnosticOk               = { fg = c.diag.fg_ok },
            DiagnosticDeprecated       = { sp = c.diag.sp_deprecated, undercurl = true, dim = true },
            DiagnosticUnnecessary      = { fg = c.NONE, dim = true },
            --
            DiagnosticUnderlineError   = { sp = c.diag.fg_error, underline = true },
            DiagnosticUnderlineWarn    = { sp = c.diag.fg_warning, underline = true },
            DiagnosticUnderlineInfo    = { sp = c.diag.fg_info, underline = true },
            DiagnosticUnderlineHint    = { sp = c.diag.fg_hint, underline = true },
            DiagnosticUnderlineOk      = { sp = c.diag.fg_ok, underline = true },
            --
            DiagnosticFloatingError    = { fg = c.diag.fg_error },
            DiagnosticFloatingWarn     = { fg = c.diag.fg_warning },
            DiagnosticFloatingInfo     = { fg = c.diag.fg_info },
            DiagnosticFloatingHint     = { fg = c.diag.fg_hint },
            DiagnosticFloatingOk       = { fg = c.diag.fg_ok },
            --
            DiagnosticVirtualTextError = { fg = c.diag.fg_vtext_error, italic = true },
            DiagnosticVirtualTextWarn  = { fg = c.diag.fg_vtext_warning, italic = true },
            DiagnosticVirtualTextInfo  = { fg = c.diag.fg_vtext_info, italic = true },
            DiagnosticVirtualTextHint  = { fg = c.diag.fg_vtext_hint, italic = true },
            DiagnosticVirtualTextOk    = { fg = c.diag.fg_vtext_ok, italic = true },
            --
            DiagnosticSignError        = { fg = c.diag.fg_error },
            DiagnosticSignWarn         = { fg = c.diag.fg_warning },
            DiagnosticSignInfo         = { fg = c.diag.fg_info },
            DiagnosticSignHint         = { fg = c.diag.fg_hint },
            DiagnosticSignOk           = { fg = c.diag.fg_ok },
        },
        nvim = {
            healthSectionDelim = { link = "Title" },
        },
        todos = {
            SpecialComment = { fg = "#ff0111", bg = "#a6c44f" },
            Debug          = { fg = "#ff0112", bg = "#a6c450" },
            ColorColumn    = { fg = "#ff0113", bg = "#a6c451" },
            CursorColumn   = { fg = "#ff0118", bg = "#a6c456" },
            Folded         = { fg = "#ff011b", bg = "#a6c459" },
            FoldColumn     = { fg = "#ff011c", bg = "#a6c45a" },
            WildMenu       = { fg = "#ff0122", bg = "#a6c460" },
            Menu           = { fg = "#ff0125", bg = "#a6c463" },
            Scrollbar      = { fg = "#ff0126", bg = "#a6c464" },
            Tooltip        = { fg = "#ff0127", bg = "#a6c465" },
            TermCursor     = { fg = "#ff0128", bg = "#a6c466" },
            TermCursorNC   = { fg = "#ff0129", bg = "#a6c467" },
            CursorLineFold = { fg = "#ff012e", bg = "#a6c46c" },
            PmenuKind      = { fg = "#ff0130", bg = "#a6c46e" },
            PmenuKindSel   = { fg = "#ff0131", bg = "#a6c46f" },
            PmenuExtra     = { fg = "#ff0132", bg = "#a6c470" },
            PmenuExtraSel  = { fg = "#ff0133", bg = "#a6c471" },
        },
        lsp = {
            ["@lsp.type.boolean"]                   = { link = "BuiltinType" },
            ["@lsp.type.builtinType"]               = { link = "BuiltinType" },
            ["@lsp.type.enum"]                      = { link = "Type" },
            ["@lsp.type.enum.odin"]                 = { link = "Type" },
            ["@lsp.type.enumMember"]                = { link = "Constant" },
            ["@lsp.type.enumMember.odin"]           = { link = "Constant" },
            ["@lsp.type.escapeSequence"]            = { link = "Keyword" },
            ["@lsp.type.formatSpecifier"]           = { link = "Keyword" },
            ["@lsp.type.keyword"]                   = { link = "Keyword" },
            ["@lsp.type.namespace.odin"]            = { link = "Variable" },
            ["@lsp.type.number"]                    = { link = "Number" },
            ["@lsp.type.property"]                  = { link = "Property" },
            ["@lsp.type.string"]                    = { link = "String" },
            ["@lsp.type.type"]                      = { link = "Type" },
            ["@lsp.typemod.class.defaultLibrary"]   = { link = "BuiltinType" },
            ["@lsp.typemod.enum.defaultLibrary"]    = { link = "BuiltinType" },
            ["@lsp.typemod.enum.readonly.odin"]     = { link = "Type" },
            ["@lsp.typemod.string.injected"]        = { link = "String" },
            ["@lsp.typemod.struct.defaultLibrary"]  = { link = "BuiltinType" },
            ["@lsp.typemod.type.defaultLibrary"]    = { link = "BuiltinType" },
            ["@lsp.typemod.variable.fileScope"]     = { link = "GlobalVariable" },
            ["@lsp.typemod.variable.globalScope"]   = { link = "GlobalVariable" },
            ["@lsp.typemod.variable.readonly.odin"] = { link = "Constant" },
            ["@lsp.typemod.variable.static"]        = { link = "Constant" },
        },
    }

    -- NOTE 09/05/26 HSU: Plugin group names should be the package name of the corresponding plugin.
    -- Highlights are only loaded if `package.loaded[<group name>] == true`.
    local plugin_groups = {
        ["cmp"] = {
            CmpItemAbbrDeprecated = { fg = c.fg_unused, strikethrough = true, },
            --
            CmpItemAbbrMatch      = { fg = c.fg_editor },
            CmpItemAbbrMatchFuzzy = { fg = c.fg_editor_dim },
            --
            CmpItemKindVariable   = { fg = c.fg_field },
            CmpItemKindInterface  = { link = 'CmpItemKindVariable' },
            CmpItemKindText       = { link = 'CmpItemKindVariable' },
            --
            CmpItemKindFunction   = { fg = c.fg_function },
            CmpItemKindMethod     = { link = 'CmpItemKindFunction' },
            --
            CmpItemKindKeyword    = { fg = c.fg_keyword },
            CmpItemKindProperty   = { link = 'CmpItemKindKeyword' },
            CmpItemKindUnit       = { link = 'CmpItemKindKeyword' },
        },
        ["telescope"] = {
            TelescopePromptNormal  = { bg = c.bg_float, },
            TelescopePromptBorder  = { bg = c.bg_float, },
            TelescopePromptTitle   = { bg = c.bg_float, fg = c.fg_comment, bold = true },
            TelescopePreviewNormal = { bg = c.bg_dark },
            TelescopePreviewBorder = { bg = c.bg_light },
            TelescopePreviewTitle  = { bg = c.bg_light, italic = true },
            TelescopeResultsNormal = { bg = c.bg_light },
            TelescopeResultsBorder = { bg = c.bg_light },
            TelescopeResultsTitle  = { bg = c.bg_light },
            TelescopeMatching      = { fg = c.fg_editor },
        },
        ["flash"] = {
            FlashPrompt     = { fg = c.NONE, bg = c.bg_statusline, bold = true, italic = true },
            FlashPromptIcon = { fg = c.fg_editor, bg = c.bg_statusline, bold = true, italic = false, nocombine = true },
            FlashBackdrop   = { fg = c.fg_comment, nocombine = true },
            Flashcurrent    = { fg = c.fg_keyword_dim, bg = c.bg_cursearch, bold = false, nocombine = true, dim = false },
            FlashMatch      = { fg = c.fg_keyword_dim, bold = false, nocombine = true, dim = false },
            FlashLabel      = { fg = c.fg_editor, bold = true, italic = false, nocombine = true, underline = false, sp = c.fg_number },
        },
        ["mini.cursorword"] = {
            MiniCursorword        = { underline = true, sp = c.fg_normal },
            MiniCursorwordCurrent = { link = "MiniCursorword" },
        },
        ["mini.indentscope"] = {
            MiniIndentscopeSymbol = { link = "Whitespace" },
        },
        ["gitsigns"] = {
            GitSignsAdd                  = { fg = c.diff.add_gutter },
            GitSignsChange               = { fg = c.diff.change_gutter },
            GitSignsDelete               = { fg = c.diff.delete_gutter },
            GitSignsStagedAdd            = { link = "GitSignsAdd" },
            GitSignsStagedChange         = { link = "GitSignsChange" },
            GitSignsStagedDelete         = { link = "GitSignsDelete" },
            GitSignsStagedChangedelete   = { link = "GitSignsChange" },
            GitSignsStagedTopdelete      = { link = "GitSignsDelete" },
            GitSignsStagedAddNr          = { link = "GitSignsAdd" },
            GitSignsStagedChangeNr       = { link = "GitSignsChange" },
            GitSignsStagedDeleteNr       = { link = "GitSignsDelete" },
            GitSignsStagedChangedeleteNr = { link = "GitSignsChange" },
            GitSignsStagedTopdeleteNr    = { link = "GitSignsDelete" },
            GitSignsStagedAddLn          = { link = "GitSignsAdd" },
            GitSignsStagedChangeLn       = { link = "GitSignsChange" },
            GitSignsStagedChangedeleteLn = { link = "GitSignsChange" },
        },
        ["oil-git"] = {
            OilDir                 = { fg = c.fg_function, bold = true },
            OilDirHidden           = { fg = c.fg_keyword_dim, bold = false },
            OilGitAdded            = { link = "DiffAdd" },
            OilGitModifiedStaged   = { link = "DiffChange" },
            OilGitModifiedUnstaged = { link = "DiffChange" },
            OilGitBranch           = { link = "Normal" },
            OilGitRenamed          = { link = "DiffChange" },
            OilGitDeleted          = { link = "DiffDelete" },
            OilGitCopied           = { link = "DiffChange" },
            OilGitConflict         = { link = "Diagnosticwarn" },
            OilGitUntracked        = { link = "Type" },
            OilGitIgnored          = { link = "Comment" },
        },
    }

    -- NOTE 09/05/26 HSU: Treesitter group names should be the name of the corresponding treesitter language.
    -- Highlights are only loaded if `require("nvim-treesitter").get_installed() contains <group name>`.
    local treesitter_groups = {
        ["odin"] = {
            ["@attribute.odin"]           = { link = "Keyword" },
            ["@constant.builtin.odin"]    = { link = "Keyword" },
            ["@constant.odin"]            = { link = "Constant" },
            ["@number.float.odin"]        = { link = "Number" },
            ["@number.float.zig"]         = { link = "Number" }, -- TODO 03/11/26 HSU: Zig???
            ["@punctuation.special.odin"] = { link = "Keyword" },
            ["@variable.builtin.odin"]    = { link = "Keyword" },
            ["@variable.member.odin"]     = { link = "Field" },
        },
        ["slang"] = {
            ["@attribute.slang"] = { link = "Keyword" },
        }
    }


    local function set_or_maybe_clear_hl(group, do_set_hl)
        for hl_name, hl_val in pairs(group) do
            if do_set_hl or next(vim.api.nvim_get_hl(0, { name = hl_name, create = false })) then
                vim.api.nvim_set_hl(0, hl_name, (do_set_hl and hl_val) or {})
            end
        end
    end

    for _, group in pairs(default_groups) do
        set_or_maybe_clear_hl(group, true)
    end

    local function handle_plugin_groups()
        for group_name, group in pairs(plugin_groups) do
            set_or_maybe_clear_hl(group, package.loaded[group_name] ~= nil)
        end

        if package.loaded["nvim-treesitter"] then
            local installed_langs = require("nvim-treesitter").get_installed()

            for lang_name, lang_group in pairs(treesitter_groups) do
                set_or_maybe_clear_hl(lang_group, vim.list_contains(installed_langs, lang_name))
            end
        end
    end

    if vim.v.vim_did_enter == 0 then
        vim.api.nvim_create_autocmd('VimEnter', {
            group = vim.api.nvim_create_augroup("simplerdarcula", { clear = true }),
            -- command = 'colorscheme simplerdarcula',
            callback = handle_plugin_groups,
            once = true,
        })
        return
    end

    handle_plugin_groups()

    -- vim.api.nvim_create_autocmd("ModeChanged", {
    --     desc = "Flash labels are not ugly in visual mode.",
    --     pattern = "*:[vV\x16]*",
    --     callback = function()
    --         vim.api.nvim_set_hl(0, "FlashLabel", {
    --             -- nocombine = true,
    --             -- fg = c.NONE,
    --             -- bg = c.NONE,
    --             bold = false,
    --             -- reverse = true,
    --             update = true,
    --         })
    --     end,
    -- })
    --
    -- vim.api.nvim_create_autocmd("ModeChanged", {
    --     desc = "Flash labels are not ugly in visual mode reset.",
    --     pattern = "*[vV\x16]:*",
    --     callback = function()
    --         vim.api.nvim_set_hl(0, "flashlabel", {
    --             -- bg = c.none,
    --             -- nocombine = true,
    --             bold = true,
    --             -- reverse = false,
    --             update = true,
    --         })
    --     end,
    -- })
end
