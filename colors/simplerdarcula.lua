------------------------
---- DEFAULT GROUPS ----
------------------------

-- ColorColumn     Used for the columns set with 'colorcolumn'.
-- Conceal         Placeholder characters substituted for concealed text (see 'conceallevel').
-- CurSearch       Used for highlighting a search pattern under the cursor (see 'hlsearch').
-- Cursor          Character under the cursor.
-- lCursor         Character under the cursor when |language-mapping| is used (see 'guicursor').
-- CursorIM        Like Cursor, but used when in IME mode. *CursorIM*
-- CursorColumn    Screen-column at the cursor, when 'cursorcolumn' is set.
-- CursorLine      Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
-- Directory       Directory names (and other special names in listings).
-- DiffAdd         Diff mode: Added line. |diff.txt|
-- DiffChange      Diff mode: Changed line. |diff.txt|
-- DiffDelete      Diff mode: Deleted line. |diff.txt|
-- DiffText        Diff mode: Changed text within a changed line. |diff.txt|
-- EndOfBuffer     Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
-- TermCursor      Cursor in a focused terminal.
-- TermCursorNC    Cursor in an unfocused terminal.
-- ErrorMsg        Error messages on the command line.
-- WinSeparator    Separators between window splits.
-- Folded          Line used for closed folds.
-- FoldColumn      'foldcolumn'
-- SignColumn      Column where |signs| are displayed.
-- IncSearch       'incsearch' highlighting; also used for the text replaced with ":s///c".
-- Substitute      |:substitute| replacement text highlighting.
-- LineNr          Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
-- LineNrAbove     Line number for when the 'relativenumber' option is set, above the cursor line.
-- LineNrBelow     Line number for when the 'relativenumber' option is set, below the cursor line.
-- CursorLineNr    Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
-- CursorLineFold  Like FoldColumn when 'cursorline' is set for the cursor line.
-- CursorLineSign  Like SignColumn when 'cursorline' is set for the cursor line.
-- MatchParen      Character under the cursor or just before it, if it is a paired bracket, and its match.
-- ModeMsg         'showmode' message (e.g., "-- INSERT --").
-- MsgArea         Area for messages and cmdline.
-- MsgSeparator    Separator for scrolled messages |msgsep|.
-- MoreMsg         |more-prompt|
-- NonText         '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text
--                 (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
-- Normal          Normal text.
-- NormalFloat     Normal text in floating windows.
-- FloatBorder     Border of floating windows.
-- FloatTitle      Title of floating windows.
-- NormalNC        Normal text in non-current windows.
-- Pmenu           Popup menu: Normal item.
-- PmenuSel        Popup menu: Selected item.
-- PmenuKind       Popup menu: Normal item "kind".
-- PmenuKindSel    Popup menu: Selected item "kind".
-- PmenuExtra      Popup menu: Normal item "extra text".
-- PmenuExtraSel   Popup menu: Selected item "extra text".
-- PmenuSbar       Popup menu: Scrollbar.
-- PmenuThumb      Popup menu: Thumb of the scrollbar.
-- Question        |hit-enter| prompt and yes/no questions.
-- QuickFixLine    Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
-- Search          Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
-- SpecialKey      Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
-- SpellBad        Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
-- SpellCap        Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
-- SpellLocal      Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
-- SpellRare       Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
-- StatusLine      Status line of current window.
-- StatusLineNC    Status lines of not-current windows. Note: If this is equal to "StatusLine", Vim will use "^^^" in the status line of the current window.
-- TabLine         Tab pages line, not active tab page label.
-- TabLineFill     Tab pages line, where there are no labels.
-- TabLineSel      Tab pages line, active tab page label.
-- Title           Titles for output from ":set all", ":autocmd" etc.
-- Visual          Visual mode selection.
-- VisualNOS       Visual mode selection when vim is "Not Owning the Selection".
-- WarningMsg      Warning messages.
-- Whitespace      "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
-- WildMenu        Current match in 'wildmenu' completion.
-- WinBar          Window bar of current window.
-- WinBarNC        Window bar of not-current windows.
-- PreProc         generic Preprocessor
-- Include         preprocessor #include
-- Define          preprocessor #define
-- Macro           same as Define
-- PreCondit       preprocessor #if, #else, #endif, etc.
--
--
--             For the GUI you can use the following groups to set the colors for the menu,
--             scrollbars and tooltips.  They don't have defaults.  This doesn't work for the
--             Win32 GUI.  Only three highlight arguments have any effect here: font, guibg,
--             and guifg.
--
-- Menu            Current font, background and foreground colors of the menus.
--                 Also used for the toolbar.
--                 Applicable highlight arguments: font, guibg, guifg.
--
-- Scrollbar       Current background and foreground of the main window's
--                 scrollbars.
--                 Applicable highlight arguments: guibg, guifg.
--
-- Tooltip         Current font, background and foreground of the tooltips.
--                 Applicable highlight arguments: font, guibg, guifg.

---------------------
---- CODE GROUPS ----
---------------------

-- {val}    Highlight definition map, accepts the following keys:
--            • fg (or foreground): color name or "#RRGGBB", see note.
--            • bg (or background): color name or "#RRGGBB", see note.
--            • sp (or special): color name or "#RRGGBB"
--            • blend: integer between 0 and 100
--            • bold: boolean
--            • standout: boolean
--            • underline: boolean
--            • undercurl: boolean
--            • underdouble: boolean
--            • underdotted: boolean
--            • underdashed: boolean
--            • strikethrough: boolean
--            • italic: boolean
--            • reverse: boolean
--            • nocombine: boolean
--            • link: name of another highlight group to link to, see
--              |:hi-link|.
--            • default: Don't override existing definition |:hi-default|
--            • ctermfg: Sets foreground of cterm color |ctermfg|
--            • ctermbg: Sets background of cterm color |ctermbg|
--            • cterm: cterm attribute map, like |highlight-args|. If not
--              set, cterm attributes will match those from the attribute
--              map documented above.

local fg_normal = "#e0e2ea"
-- stylua: ignore start
local c = {
    NONE            = "none",

    fg_normal       = fg_normal, -- "#cccccc",
    fg_normal_sbar  = "#707070", -- "#cccccc",
    fg_float_sbar   = "#707070", -- "#cccccc",
    -- fg_punctuation  = fg_normal, -- "#aaaaaa",
    fg_punctuation  = "#b0b0b0", -- "#aaaaaa",
    fg_string       = "#91b3d8", -- "#91b3d8",
    fg_number       = "#FFFFFF", -- "#ffffff",
    fg_type         = "#b0b0b0", -- "#cbcbcb",
    fg_builtintype  = "#fcd3af", -- "#cbcbcb",
    fg_special      = "#fcd3af", -- fg_normal, -- "#cbcbcc",
    fg_operator     = fg_normal, -- "#fcd3b0",
    fg_border       = "#303030", -- "#424242", -- buffer separator
    fg_comment      = "#707070", -- "#707070",
    fg_keyword      = "#fcd3af", -- "#fcd3ad",
    fg_keyword_dim  = "#907964", -- "#fcd3ad",
    fg_cursorlinenr = "#707070", -- "#464646", -- cursorlinenr
    fg_whitespace   = "#323232", -- "#464646", -- cursorlinenr
    fg_gutter       = "#474747", -- "#474747", -- line number
    fg_sidebar      = "#ff00ff", -- "#cecece",
    fg_variable     = "#e0e2ea", -- "#d0d0d0",
    -- fg_function     = "#996c46", -- "#996c46",
    fg_function     = "#d09b6e", -- "#996c46",
    -- fg_field        = "#d09b6e", -- fields used to be orange?
    fg_field        = fg_normal,
    -- fg_field        = "none",
    fg_macro        = "#cccccc", -- "#fcd3af",
    fg_statement    = "#fcd3af", -- "#fcd3af", -- statement, identifier,
    fg_identifier   = "#cccccc", -- "#fcd3af", -- statement, identifier,
    fg_todo         = "#a6c43d", -- "#a6c43d",
    fg_unused       = "#707070", -- "#484848", -- unused function, unused variable
    fg_constant     = fg_normal, -- "#a6744a", -- number (remap), boolean, matched brace (remap), constant
    fg_editor       = "#ff9e64", -- "#ffc739"
    fg_editor_dim   = "#915a39", -- "#ffc739"
    fg_motion_label = "#dd0070",

    bg_faint        = "#282828",
    bg_light        = "#303030", -- "#b4b4b4",
    bg_dark         = "#242424", -- "#242424",
    bg_border       = "#202020", -- "#242424",
    bg_normal       = "#242424", -- "#242424", -- TODO: if using light theme then light and vice versa
    bg_normal_sbar  = "#303030", -- "#242424", -- TODO: if using light theme then light and vice versa
    bg_float        = "#303030", -- "#303030", -- TODO: if using light theme then dark and vice versa
    bg_float_sbar   = "#343434", -- "#303030", -- TODO: if using light theme then dark and vice versa
    bg_cursorline   = "#303030", -- "#343434",
    bg_visual       = "#42372C", -- "#2d3f76",
    bg_search       = "#2d4c9d", -- "#3e68d7",
    bg_incsearch    = "#2e58c1", -- "#2e58c1",
    bg_cursearch    = "#11709b", -- "#2e58c1",
    bg_sidebar      = "#242424", -- "#242424",
    bg_statusline   = "#303030", -- "#242424",

    diag            = {
        fg_error             = "#e26a75",
        fg_warning           = "#ffc739",
        fg_info              = "#d0d0d0",
        fg_hint              = "#405055",
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

-- local fg_normal = "#242424"
-- -- stylua: ignore start
-- local c = {
--     NONE            = "none",
--
--     fg_normal       = fg_normal, -- "#cccccc",
--     fg_normal_sbar  = "#707070", -- "#cccccc",
--     fg_float_sbar   = "#707070", -- "#cccccc",
--     -- fg_punctuation  = fg_normal, -- "#aaaaaa",
--     fg_punctuation  = "#b0b0b0", -- "#aaaaaa",
--     fg_string       = "#91b3d8", -- "#91b3d8",
--     fg_number       = "#FFFFFF", -- "#ffffff",
--     fg_type         = "#b0b0b0", -- "#cbcbcb",
--     fg_builtintype  = "#fcd3af", -- "#cbcbcb",
--     fg_special      = fg_normal, -- "#cbcbcc",
--     fg_operator     = fg_normal, -- "#fcd3b0",
--     fg_border       = "#909090", -- "#424242", -- buffer separator
--     fg_comment      = "#505050", -- "#707070",
--     fg_keyword      = "#fcd3af", -- "#fcd3ad",
--     fg_keyword_dim  = "#907964", -- "#fcd3ad",
--     fg_cursorlinenr = "#707070", -- "#464646", -- cursorlinenr
--     fg_whitespace   = "#757575", -- "#464646", -- cursorlinenr
--     fg_gutter       = "#b0b0b0", -- "#474747", -- line number
--     fg_sidebar      = "#ff00ff", -- "#cecece",
--     fg_variable     = "#e0e2ea", -- "#d0d0d0",
--     -- fg_function     = "#996c46", -- "#996c46",
--     fg_function     = "#d09b6e", -- "#996c46",
--     -- fg_field        = "#d09b6e", -- fields used to be orange?
--     fg_field        = fg_normal,
--     -- fg_field        = "none",
--     fg_macro        = "#cccccc", -- "#fcd3af",
--     fg_statement    = "#fcd3af", -- "#fcd3af", -- statement, identifier,
--     fg_identifier   = "#cccccc", -- "#fcd3af", -- statement, identifier,
--     fg_todo         = "#a6c43d", -- "#a6c43d",
--     fg_unused       = "#707070", -- "#484848", -- unused function, unused variable
--     fg_constant     = fg_normal, -- "#a6744a", -- number (remap), boolean, matched brace (remap), constant
--     fg_editor       = "#ff9e64", -- "#ffc739"
--     fg_editor_dim   = "#915a39", -- "#ffc739"
--     fg_motion_label = "#dd0070",
--
--     bg_faint        = "#868686",
--     bg_light        = "#909090", -- "#b4b4b4",
--     bg_dark         = "#808080", -- "#242424",
--     bg_border       = "#707070", -- "#242424",
--     bg_normal       = "#808080", -- "#242424", -- TODO: if using light theme then light and vice versa
--     bg_normal_sbar  = "#909090", -- "#242424", -- TODO: if using light theme then light and vice versa
--     bg_float        = "#909090", -- "#303030", -- TODO: if using light theme then dark and vice versa
--     bg_float_sbar   = "#a0a0a0", -- "#303030", -- TODO: if using light theme then dark and vice versa
--     bg_cursorline   = "#707070", -- "#343434",
--     bg_visual       = "#42372C", -- "#2d3f76",
--     bg_search       = "#2d4c9d", -- "#3e68d7",
--     bg_incsearch    = "#2e58c1", -- "#2e58c1",
--     bg_cursearch    = "#11709b", -- "#2e58c1",
--     bg_sidebar      = "#808080", -- "#242424",
--     bg_statusline   = "#909090", -- "#242424",
--
--     diag            = {
--         fg_error             = "#e26a75",
--         fg_warning           = "#ffc739",
--         fg_info              = "#d0d0d0",
--         fg_hint              = "#405055",
--         fg_ok                = "#b8db87",
--         fg_unnecessary       = "#707070",
--
--         fg_vtext_error       = "#893038",
--         fg_vtext_warning     = "#463B12",
--         fg_vtext_info        = "#404040",
--         fg_vtext_hint        = "#404040",
--         fg_vtext_ok          = "#455430",
--
--         fg_vtext_unnecessary = "#707070",
--         sp_deprecated        = "#ffc739",
--     },
--     diff            = {
--         add           = "#b8db87",
--         change        = "#7ca1f2",
--         delete        = "#e26a75",
--         ignore        = "#ffc739",
--         text          = "#545c7e",
--         add_gutter    = "#587C58",
--         change_gutter = "#5767A2",
--         delete_gutter = "#656E76",
--     },
-- }

local groups = {
    Normal                     = { fg = c.fg_normal, bg = c.bg_normal },
    -- NormalNC    = { fg = c.fg_normal, bg = c.bg_light },
    NormalNC                   = { link = "Normal" },
    -- NormalNC                   = { bg = c.bg_border },
    EndOfBuffer                = { link = "Normal" },
    NormalFloat                = { bg = c.bg_float },
    FloatTitle                 = { fg = c.fg_normal, bg = c.bg_float, bold = true },
    FloatBorder                = { link = "NormalFloat" },
    Pmenu                      = { bg = c.bg_float },
    PmenuSel                   = { bg = c.bg_search },
    PmenuSbar                  = { bg = c.bg_float_sbar },
    PmenuThumb                 = { bg = c.fg_float_sbar },
    MoreMsg                    = { fg = c.fg_normal, bg = c.bg_float, bold = true },
    Visual                     = { bg = c.bg_visual },
    Search                     = { bg = c.bg_search },
    CurSearch                  = { bg = c.bg_cursearch },
    IncSearch                  = { bg = c.bg_incsearch },
    MatchParen                 = { bg = c.bg_incsearch },
    Cursor                     = { fg = c.bg_normal, bg = c.fg_normal, reverse = false },
    CursorLine                 = { bg = c.bg_cursorline },
    CursorLineNr               = { fg = c.fg_cursorlinenr },
    LineNr                     = { fg = c.fg_gutter },
    LineNrAbove                = { link = "LineNr" },
    LineNrBelow                = { link = "LineNr" },
    WinSeparator               = { fg = c.fg_border },
    StatusLine                 = { bg = c.bg_statusline, italic = true }, -- to avoid ^ in statusline
    Title                      = { bold = true },
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
    MsgArea                    = { link = "normal" },
    SignColumn                 = { bg = c.bg_normal },
    CursorLineSign             = { link = "CursorLineNr" },
    ModeMsg                    = { link = "MsgArea" },
    MsgSeparator               = { link = "WinSeparator" },
    Question                   = { link = "SpecialKey" },

    TabLineSel                 = { bold = true }, -- Currently selected tab, the bg defines the line that marks the active tab.
    TabLine                    = { bg = c.bg_light },
    TabLineFill                = { bg = c.bg_light },

    Type                       = { fg = c.fg_type },
    BuiltinType                = { fg = c.fg_builtintype },
    Boolean                    = { link = "BuiltinType" },
    Float                      = { link = "BuiltinType" },
    Structure                  = { link = "Type" },
    String                     = { fg = c.fg_string },
    Character                  = { link = "String" },
    Number                     = { fg = c.fg_number },
    Variable                   = { fg = c.fg_variable },
    GlobalVariable             = { fg = c.fg_constant, italic = true }, -- TODO: Should this be unique?
    Constant                   = { fg = c.fg_constant },
    Include                    = { fg = c.fg_keyword },
    Define                     = { fg = c.fg_keyword },
    StorageClass               = { fg = c.fg_normal },
    Macro                      = { fg = c.fg_macro }, -- TODO: Should this be unique?
    PreCondit                  = { link = "Keyword" },
    Tag                        = { link = "Underlined" },
    Typedef                    = { link = "Type" },
    Exception                  = { link = "Error" },

    cDefine                    = { fg = c.fg_keyword },
    cTypedef                   = { fg = c.fg_keyword },
    cppType                    = { link = "BuiltinType" },
    cType                      = { link = "BuiltinType" },

    Function                   = { fg = c.fg_function },
    Identifier                 = { fg = c.fg_identifier },
    Field                      = { fg = c.fg_field },
    Property                   = { link = "Field" },
    Conditional                = { fg = c.fg_keyword },
    Statement                  = { fg = c.fg_statement },
    Operator                   = { fg = c.fg_operator },
    Keyword                    = { fg = c.fg_keyword },
    Repeat                     = { link = "Keyword" },                -- Loops etc.
    Label                      = { fg = c.fg_number, italic = true }, -- underdashed, underdotted, standout,
    SpecialChar                = { link = "Keyword" },                -- String escape etc.

    Spellbad                   = { undercurl = true, sp = c.diag.fg_error },
    SpellCap                   = { undercurl = true, sp = c.diag.fg_warning },
    SpellLocal                 = { undercurl = true, sp = c.diag.fg_hint },
    SpellRare                  = { undercurl = true, sp = c.diag.fg_hint },

    DiffAdd                    = { fg = c.diff.add },
    DiffChange                 = { fg = c.diff.change },
    DiffDelete                 = { fg = c.diff.delete },
    DiffText                   = { fg = c.diff.text },

    Error                      = { fg = c.diag.fg_error },
    ErrorMsg                   = { fg = c.diag.fg_error },
    WarningMsg                 = { fg = c.diag.fg_warning },

    DiagnosticError            = { fg = c.diag.fg_error },
    DiagnosticWarn             = { fg = c.diag.fg_warning },
    DiagnosticInfo             = { fg = c.diag.fg_info },
    DiagnosticHint             = { fg = c.diag.fg_hint, italic = true },
    DiagnosticOk               = { fg = c.diag.fg_ok },
    DiagnosticDeprecated       = { strikethrough = true, sp = c.diag.sp_deprecated }, -- TODO: this should be undercurled or something
    DiagnosticUnnecessary      = { fg = c.diag.fg_unnecessary },                      -- TODO: probably just link to unused

    DiagnosticUnderlineError   = { sp = c.diag.fg_error, underline = true },
    DiagnosticUnderlineWarn    = { sp = c.diag.fg_warning, underline = true },
    DiagnosticUnderlineInfo    = { sp = c.diag.fg_info, underline = true },
    DiagnosticUnderlineHint    = { sp = c.diag.fg_hint, underline = true },
    DiagnosticUnderlineOk      = { sp = c.diag.fg_ok, underline = true },

    DiagnosticFloatingError    = { fg = c.diag.fg_error },
    DiagnosticFloatingWarn     = { fg = c.diag.fg_warning },
    DiagnosticFloatingInfo     = { fg = c.diag.fg_info },
    DiagnosticFloatingHint     = { fg = c.diag.fg_hint },
    DiagnosticFloatingOk       = { fg = c.diag.fg_ok },

    DiagnosticVirtualTextError = { fg = c.diag.fg_vtext_error, italic = true },
    DiagnosticVirtualTextWarn  = { fg = c.diag.fg_vtext_warning, italic = true },
    DiagnosticVirtualTextInfo  = { fg = c.diag.fg_vtext_info, italic = true },
    DiagnosticVirtualTextHint  = { fg = c.diag.fg_vtext_hint, italic = true },
    DiagnosticVirtualTextOk    = { fg = c.diag.fg_vtext_ok, italic = true },

    DiagnosticSignError        = { fg = c.diag.fg_error },
    DiagnosticSignWarn         = { fg = c.diag.fg_warning },
    DiagnosticSignInfo         = { fg = c.diag.fg_info },
    DiagnosticSignHint         = { fg = c.diag.fg_hint },
    DiagnosticSignOk           = { fg = c.diag.fg_ok },

    IlluminatedWordText        = { bg = c.bg_cursorline },
    IlluminatedWordRead        = { link = "IlluminatedWordText" },
    IlluminatedWordWrite       = { link = "IlluminatedWordText" },

    MiniIndentscopeSymbol      = { link = "Whitespace" },
}

local nvim_cmp_groups = {
    CmpItemAbbrDeprecated = { fg = c.fg_unused, strikethrough = true, },

    CmpItemAbbrMatch      = { fg = c.fg_editor },
    CmpItemAbbrMatchFuzzy = { fg = c.fg_editor_dim },

    CmpItemKindVariable   = { fg = c.fg_field },
    CmpItemKindInterface  = { link = 'CmpItemKindVariable' },
    CmpItemKindText       = { link = 'CmpItemKindVariable' },

    CmpItemKindFunction   = { fg = c.fg_function },
    CmpItemKindMethod     = { link = 'CmpItemKindFunction' },

    CmpItemKindKeyword    = { fg = c.fg_keyword },
    CmpItemKindProperty   = { link = 'CmpItemKindKeyword' },
    CmpItemKindUnit       = { link = 'CmpItemKindKeyword' },
}

-- local leap_groups = {
--     LeapBackdrop = { link = 'Comment' }, -- or some grey
--     LeapMatch = { fg = c.fg_number, bold = true, nocombine = true, },
--     LeapLabel = { fg = c.fg_motion_label, bold = true, italic = true, nocombine = false },
-- }


local flash_groups = {
    FlashBackdrop = { link = 'Comment' },                                                 -- or some grey
    -- FlashCurrent = { fg = c.fg_number, bg = c.bg_search, bold = true, nocombine = true }, -- or some grey
    FlashCurrent = { fg = c.fg_number, bg = c.bg_search, bold = true, nocombine = true }, -- or some grey
    FlashMatch = { fg = c.fg_number, bold = true, nocombine = true, },
    FlashLabel = { fg = c.fg_motion_label, bold = true, italic = true, nocombine = false },
}

local vimtex_groups = {
    texMathZoneX = { link = 'Number' },
    texMathMatcher = { link = 'texMathZoneX' },
    texMathOper = { link = 'texMathZoneX' },
    texSuperscript = { link = 'texMathZoneX' },
}

local lsp_groups = {
    -- LSP Semantic Token Groups
    ["@lsp.type.boolean"]                   = { link = "BuiltinType" },
    ["@lsp.type.builtinType"]               = { link = "BuiltinType" },
    ["@lsp.type.enum"]                      = { link = "Type" },
    ["@lsp.type.enumMember"]                = { link = "Constant" },
    ["@lsp.type.escapeSequence"]            = { link = "Keyword" },
    ["@lsp.type.formatSpecifier"]           = { link = "Keyword" },
    ["@lsp.type.keyword"]                   = { link = "Keyword" },
    ["@lsp.type.type"]                      = { link = "Type" },
    ["@lsp.type.property"]                  = { link = "Property" },
    ["@lsp.typemod.class.defaultLibrary"]   = { link = "BuiltinType" },
    ["@lsp.typemod.enum.defaultLibrary"]    = { link = "BuiltinType" },
    ["@lsp.typemod.struct.defaultLibrary"]  = { link = "BuiltinType" },
    ["@lsp.typemod.type.defaultLibrary"]    = { link = "BuiltinType" },
    ["@lsp.type.string"]                    = { link = "String" },
    ["@lsp.typemod.string.injected"]        = { link = "String" },
    ["@lsp.typemod.variable.static"]        = { link = "Constant" },
    ["@lsp.typemod.variable.globalScope"]   = { link = "GlobalVariable" },
    ["@lsp.typemod.variable.fileScope"]     = { link = "GlobalVariable" },
    ["@lsp.type.number"]                    = { link = "Number" },
    ["@lsp.type.namespace.odin"]            = { link = "Variable" },
    ["@lsp.type.enum.odin"]                 = { link = "Type" },
    ["@lsp.type.enumMember.odin"]           = { link = "Constant" },
    ["@lsp.typemod.variable.readonly.odin"] = { link = "Constant" },
    ["@lsp.typemod.enum.readonly.odin"]     = { link = "Type" },
    -- ["@lsp.type.enumMember.odin"]          = { link = "Constant" },
    -- ["@lsp.type.comment"] = { link = "@comment" },
    -- ["@lsp.type.decorator"] = { link = "@attribute" },
    -- ["@lsp.type.deriveHelper"] = { link = "@attribute" },
    -- ["@lsp.type.generic"] = { link = "@variable" },
    -- ["@lsp.type.interface"] = { fg = "" }, --util.lighten(c.blue1, 0.7) },
    -- ["@lsp.type.lifetime"] = { link = "@storageclass" },
    -- ["@lsp.type.namespace"] = { link = "@namespace" },
    -- ["@lsp.type.operator"] = { link = "@operator" },
    -- ["@lsp.type.parameter"] = { link = "@parameter" },
    -- ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    -- ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
    -- ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    -- ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.error },
    -- ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
    -- ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
    -- ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    -- ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    -- ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
    -- ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
    -- ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    -- ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    -- ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = "" }, -- util.darken(c.blue1, 0.8) },
    -- ["@lsp.typemod.variable.callable"] = { link = "@function" },
    -- ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    -- ["@lsp.typemod.variable.injected"] = { link = "@variable" },

}

local treesitter_groups = {
    -- This is redundant if we get semantic tokens from zls, but I turned it off for now.
    ["@number.float.zig"]         = { link = "Number" },
    ["@number.float.odin"]        = { link = "Number" },
    ["@variable.builtin.odin"]    = { link = "Keyword" },
    ["@constant.builtin.odin"]    = { link = "Keyword" },
    ["@constant.odin"]            = { link = "Constant" },
    -- ["@label.odin"]               = { link = "" },
    -- ["@constant.odin"] = { link = "Constant", priority = 150 },
    ["@attribute.odin"]           = { link = "Keyword" },
    ["@punctuation.special.odin"] = { link = "Keyword" },
    ["@variable.member.odin"]     = { link = "Field" },
}

local mini_cursorword_groups = {
    -- MiniCursorwordCurrent = {},
    -- MiniCursorword        = { sp = c.bg_cursearch, underline = true },
    -- MiniCursorword        = { sp = c.bg_cursearch, underline = true },

}

local gitsigns_groups = {
    -- GitSignsAdd
    --          Used for the text of 'add' signs.
    -- Fallbacks: `GitGutterAdd`, `SignifySignAdd`, `DiffAddedGutter`, `Added`, `DiffAdd`
    --
    -- GitSignsChange
    --         Used for the text of 'change' signs.
    -- Fallbacks: `GitGutterChange`, `SignifySignChange`, `DiffModifiedGutter`, `Changed`, `DiffChange`
    --
    -- GitSignsDelete
    --         Used for the text of 'delete' signs.
    -- Fallbacks: `GitGutterDelete`, `SignifySignDelete`, `DiffRemovedGutter`, `Removed`, `DiffDelete`
    --
    -- GitSignsChangedelete
    --         Used for the text of 'changedelete' signs.
    -- Fallbacks: `GitSignsChange`
    --
    -- GitSignsTopdelete
    --         Used for the text of 'topdelete' signs.
    -- Fallbacks: `GitSignsDelete`
    --
    -- GitSignsUntracked
    --         Used for the text of 'untracked' signs.
    -- Fallbacks: `GitSignsAdd`
    --
    -- GitSignsAddNr
    --         Used for number column (when `config.numhl == true`) of 'add' signs.
    -- Fallbacks: `GitGutterAddLineNr`, `GitSignsAdd`
    --
    -- GitSignsChangeNr
    --         Used for number column (when `config.numhl == true`) of 'change' signs.
    -- Fallbacks: `GitGutterChangeLineNr`, `GitSignsChange`
    --
    -- GitSignsDeleteNr
    --         Used for number column (when `config.numhl == true`) of 'delete' signs.
    -- Fallbacks: `GitGutterDeleteLineNr`, `GitSignsDelete`
    --
    -- GitSignsChangedeleteNr
    --         Used for number column (when `config.numhl == true`) of 'changedelete' signs.
    -- Fallbacks: `GitSignsChangeNr`
    --
    -- GitSignsTopdeleteNr
    --         Used for number column (when `config.numhl == true`) of 'topdelete' signs.
    -- Fallbacks: `GitSignsDeleteNr`
    --
    -- GitSignsUntrackedNr
    --         Used for number column (when `config.numhl == true`) of 'untracked' signs.
    -- Fallbacks: `GitSignsAddNr`
    --
    -- GitSignsAddLn
    --         Used for buffer line (when `config.linehl == true`) of 'add' signs.
    -- Fallbacks: `GitGutterAddLine`, `SignifyLineAdd`, `DiffAdd`
    --
    -- GitSignsChangeLn
    --         Used for buffer line (when `config.linehl == true`) of 'change' signs.
    -- Fallbacks: `GitGutterChangeLine`, `SignifyLineChange`, `DiffChange`
    --
    -- GitSignsChangedeleteLn
    --         Used for buffer line (when `config.linehl == true`) of 'changedelete' signs.
    -- Fallbacks: `GitSignsChangeLn`
    --
    -- GitSignsUntrackedLn
    --         Used for buffer line (when `config.linehl == true`) of 'untracked' signs.
    -- Fallbacks: `GitSignsAddLn`
    --
    -- GitSignsAddPreview
    --         Used for added lines in previews.
    -- Fallbacks: `GitGutterAddLine`, `SignifyLineAdd`, `DiffAdd`
    --
    -- GitSignsDeletePreview
    --         Used for deleted lines in previews.
    -- Fallbacks: `GitGutterDeleteLine`, `SignifyLineDelete`, `DiffDelete`
    --
    -- GitSignsCurrentLineBlame
    --         Used for current line blame.
    -- Fallbacks: `NonText`
    --
    -- GitSignsAddInline
    --         Used for added word diff regions in inline previews.
    -- Fallbacks: `TermCursor`
    --
    -- GitSignsDeleteInline
    --         Used for deleted word diff regions in inline previews.
    -- Fallbacks: `TermCursor`
    --
    -- GitSignsChangeInline
    --         Used for changed word diff regions in inline previews.
    -- Fallbacks: `TermCursor`
    --
    -- GitSignsAddLnInline
    --         Used for added word diff regions when `config.word_diff == true`.
    -- Fallbacks: `GitSignsAddInline`
    --
    -- GitSignsChangeLnInline
    --         Used for changed word diff regions when `config.word_diff == true`.
    -- Fallbacks: `GitSignsChangeInline`
    --
    -- GitSignsDeleteLnInline
    --         Used for deleted word diff regions when `config.word_diff == true`.
    -- Fallbacks: `GitSignsDeleteInline`
    --
    -- GitSignsDeleteVirtLn
    --         Used for deleted lines shown by inline `preview_hunk_inline()` or `show_deleted()`.
    -- Fallbacks: `GitGutterDeleteLine`, `SignifyLineDelete`, `DiffDelete`
    --
    -- GitSignsDeleteVirtLnInLine
    --         Used for word diff regions in lines shown by inline `preview_hunk_inline()` or `show_deleted()`.
    -- Fallbacks: `GitSignsDeleteLnInline`

    -- GitSignsVirtLnum
    --         Used for line numbers in inline hunks previews.
    -- Fallbacks: `GitSignsDeleteVirtLn`


    GitSignsAdd                  = { fg = c.diff.add_gutter },    -- guifg=#597b60
    GitSignsChange               = { fg = c.diff.change_gutter }, -- guifg=#467c7b
    GitSignsDelete               = { fg = c.diff.delete_gutter }, -- guifg=#7f605c
    GitSignsStagedAdd            = { link = "GitSignsAdd" },      -- guifg=#597b60
    GitSignsStagedChange         = { link = "GitSignsChange" },   -- guifg=#467c7b
    GitSignsStagedDelete         = { link = "GitSignsDelete" },   -- guifg=#7f605c
    GitSignsStagedChangedelete   = { link = "GitSignsChange" },   -- guifg=#467c7b
    GitSignsStagedTopdelete      = { link = "GitSignsDelete" },   -- guifg=#7f605c
    GitSignsStagedAddNr          = { link = "GitSignsAdd" },      -- guifg=#597b60
    GitSignsStagedChangeNr       = { link = "GitSignsChange" },   -- guifg=#467c7b
    GitSignsStagedDeleteNr       = { link = "GitSignsDelete" },   -- guifg=#7f605c
    GitSignsStagedChangedeleteNr = { link = "GitSignsChange" },
    GitSignsStagedTopdeleteNr    = { link = "GitSignsDelete" },   -- guifg=#7f605c
    GitSignsStagedAddLn          = { link = "GitSignsAdd" },      -- guifg=#5c6d43
    GitSignsStagedChangeLn       = { link = "GitSignsChange" },   -- guifg=#3e5079
    GitSignsStagedChangedeleteLn = { link = "GitSignsChange" },   -- guifg=#3e5079
}

local todos = {
    SpecialComment = { fg = "#ff0111", bg = "#a6c44f" },
    Debug          = { fg = "#ff0112", bg = "#a6c450" },
    ColorColumn    = { fg = "#ff0113", bg = "#a6c451" },
    CursorColumn   = { fg = "#ff0118", bg = "#a6c456" },
    Folded         = { fg = "#ff011b", bg = "#a6c459" },
    FoldColumn     = { fg = "#ff011c", bg = "#a6c45a" },
    VisualNOS      = { fg = "#ff0121", bg = "#a6c45f" },
    WildMenu       = { fg = "#ff0122", bg = "#a6c460" },
    WinBar         = { fg = "#ff0123", bg = "#a6c461" },
    WinBarNC       = { fg = "#ff0124", bg = "#a6c462" },
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
}

-- stylua: ignore end

-- TODO: condition plugin specific groups on whether or not the plugin is present.
for name, val in pairs(groups) do
    vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(nvim_cmp_groups) do
    vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(lsp_groups) do
    vim.api.nvim_set_hl(0, name, val)
end

-- for name, val in pairs(leap_groups) do
--     vim.api.nvim_set_hl(0, name, val)
-- end

for name, val in pairs(flash_groups) do
    vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(treesitter_groups) do
    vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(mini_cursorword_groups) do
    vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(gitsigns_groups) do
    vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(vimtex_groups) do
    vim.api.nvim_set_hl(0, name, val)
end

for name, val in pairs(todos) do
    vim.api.nvim_set_hl(0, name, val)
end
