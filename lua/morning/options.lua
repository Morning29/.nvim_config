vim.g.clipboard = nil
vim.cmd('colorscheme simplerdarcula')

do
    -------------
    -- vim.opt --
    -------------

    vim.opt.rnu = true
    vim.opt.nu = true
    vim.opt.mouse = 'nvi'

    vim.opt.pumheight = 30
    vim.opt.pumwidth = 60

    vim.opt.conceallevel = 0
    vim.opt.cursorline = true
    vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

    vim.opt.ignorecase = true
    vim.opt.inccommand = 'nosplit'

    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true

    vim.opt.smartindent = true
    vim.opt.wrap = false
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.undofile = true
    vim.opt.hlsearch = true
    vim.opt.incsearch = true
    vim.opt.termguicolors = true
    vim.opt.scrolloff = 4

    vim.opt.more = true
    vim.opt.signcolumn = "yes"
    vim.opt.updatetime = 500
    vim.opt.list = true

    vim.opt.foldenable = false

    -- TODO 03/11/26 HSU: I remember adding these, but I don't remember why.
    -- vim.opt.path:append(",**/include") -- TODO 09/05/26 HSU: ???
    -- vim.opt.isfname:remove("#'") -- TODO 09/05/26 HSU: ???

    -- Default: "ltToOCF"
    vim.opt.shortmess = vim.opt.shortmess + {
        a = true, -- l+m+r+w ("1 lines, 2 bytes" -> "1L, 2B", "[Modified]" -> "[+]", "[readonly]" -> "[RO]", "written" -> "[w]", "appended" -> "[a]")
        W = true, -- don't give "written" or "[w]" when writing a file
        I = true, -- don't give the intro message when starting Vim
        c = true, -- don't give |ins-completion-menu| messages ("-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found", "Back at original", etc.)
        C = true, -- don't give messages while scanning for ins-completion items, for instance "scanning tags"
        t = true, -- truncate file message at the start if it is too long to fit on the command-line, "<" will appear in the left most column; ignored in Ex mode
    }
    -- Default: "tcqj"
    vim.opt.formatoptions = vim.opt.formatoptions + {
        j = true,  -- Attempt to remove comment char(s) when joining comment lines with 'J'
        c = true,  -- Autowrap comments when reaching 'textwidth'
        r = false, -- Automatically insert comment char(s) when pressing <Enter> in insert mode
        o = false, -- Automatically insert comment char(s) when using 'o' and 'O'
        q = true,  -- Allow formatting of comments with 'gq'
        l = true,  -- Don't format long lines in insert mode
    }

    vim.opt.cmdheight = 1
    vim.opt.autowrite = true
    vim.opt.laststatus = 2
    vim.opt.shiftround = true
    vim.opt.showmode = false

    vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

    vim.opt.sidescrolloff = 1
    vim.opt.smoothscroll = true

    vim.opt.smartcase = true

    vim.opt.splitkeep = "screen"

    vim.opt.virtualedit = "block,onemore"
    vim.opt.wildmode = "longest:full,full"

    vim.opt.fillchars = {
        foldopen = "V",
        foldclose = ">",
        fold = " ",
        foldsep = " ",
        diff = "╱",
        eob = " ",
    }
end

do
    ----------
    -- 0.13 --
    ----------

    local nvim_version = vim.version()
    if nvim_version.major < 1 and nvim_version.minor < 13 then
        require('vim._core.ui2').enable({
            enable = true,
            msg = {
                ---@type 'cmd'|'msg' Default message target, either in the
                ---cmdline or in a separate ephemeral message window.
                ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
                ---or table mapping |ui-messages| kinds and triggers to a target.
                targets = 'cmd',
                cmd = {
                    height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
                },
                dialog = {
                    height = 0.5,
                },
                msg = {
                    height = 0.5,
                    timeout = 4000, -- Time a message is visible in the message window.
                },
                pager = {
                    height = 1,
                },
            },
        })
    else
        require('vim._core.ui2').enable({
            enable = true,
            msg = {
                ---@type 'cmd'|'msg' Default message target, either in the cmdline or in a separate ephemeral message window.
                ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target or table mapping |ui-messages| kinds and triggers to a target.
                targets = 'cmd',
                cmd = { -- Options related to messages in the cmdline window.
                },
                dialog = {
                    height = 0.5, -- Maximum height.
                },
                msg = {
                    height = 0.5, -- Maximum height.
                },
                pager = {
                    height = 0.999, -- Maximum height.
                },
            },
        })

        -- default "hit-enter,history:500,progress:c"
        vim.opt.messagesopt = vim.opt.messagesopt + {
            "hit-enter",
            "history:2000",
            "progress:c",
            "maxheight:50",
            "pager:<CR>",
            "timeout:4000",
        }
    end
end
do
    --------------
    -- Platform --
    --------------

    if vim.fn.has("win32") then
        vim.g.python3_host_prog = [[C:\Python315\python.exe]]
    elseif vim.fn.has("unix") then
    elseif vim.fn.has("wsl") then
        -- This doesn't work well, consider simply never using wsl again.
        local wsl_paste = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
        vim.g.clipboard = {
            name = "WSL Clipboard",
            copy = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
            paste = { ["+"] = wsl_paste, ["*"] = wsl_paste, },
            cache_enabled = true,
        }
    end
end

do
    ----------------
    -- Statusline --
    ----------------

    -- Emulate standard status line with 'ruler' set (:h statusline)
    -- vim.opt.statusline = [[ %<%f %h%m%r%=%-14.(%y - %l,%c%V%) %P ]]

    -- Neovim default:
    -- [[\~
    --    %<%f %h%w%m%r %{% \~
    --        v:lua.require('vim._core.util').term_exitcode() \~
    --    %}%=%{% \~
    --        luaeval('(package.loaded[''vim.ui''] and vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin or -1) and vim.ui.progress_status()) or '''' ')\~
    --    %}%{% \~
    --        &showcmdloc == 'statusline' ? '%-10.S ' : '' \~
    --    %}%{% \~
    --        exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' \~
    --    %}%{% \~
    --        &busy > 0 ? '◐ ' : '' \~
    --    %}%{% \~
    --        luaeval('(package.loaded[''vim.diagnostic''] and next(vim.diagnostic.count()) and vim.diagnostic.status() .. '' '') or '''' ') \~
    --    %}%{% \~
    --        &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' \~
    --    %} \~
    -- ]]

    -- TODO 24/10/26 HSU: Put this in util and v:lua.require() it.
    function Status_Line_Mode()
        local modes = {
            -- ["n"] = "NORMAL",
            -- ["no"] = "NORMAL",
            -- ["v"] = "VISUAL",
            -- ["V"] = "VISUAL LINE",
            [""] = "^V", -- "VISUAL BLOCK",
            -- ["s"] = "SELECT",
            -- ["S"] = "SELECT LINE",
            [""] = "^S", -- "SELECT BLOCK",
            -- ["i"] = "INSERT",
            -- ["ic"] = "INSERT",
            -- ["R"] = "REPLACE",
            -- ["Rv"] = "VISUAL REPLACE",
            -- ["c"] = "COMMAND",
            -- ["cv"] = "VIM EX",
            -- ["ce"] = "EX",
            -- ["r"] = "PROMPT",
            -- ["rm"] = "MORE",
            -- ["r?"] = "CONFIRM",
            -- ["!"] = "SHELL",
            -- ["t"] = "TERMINAL",
        }
        local current_mode = vim.api.nvim_get_mode().mode
        current_mode = modes[current_mode] or current_mode
        if current_mode:len() == 1 then
            current_mode = " " .. current_mode
        end
        return ("%%#%s#%%$%s$%s%%##"):format("StatuslineNC", "Comment", current_mode)
    end

    -- TODO 03/11/26 HSU: Create a command for toggling mode display.
    local custom_statusline =
    --  [[%{% v:lua.Status_Line_Mode() %}]] ..
        [[ %<%f %#StatuslineNC#%h%w%m%r ]] ..
        [[%{% v:lua.require('vim._core.util').term_exitcode() %}]] ..
        -----------------------------------------------------------------------------
        [[%=]] ..
        -----------------------------------------------------------------------------
        [[%{% luaeval('(package.loaded[''vim.ui''] and vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin or -1) and vim.ui.progress_status()) or '''' ')%}]] ..
        [[%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %} ]] ..
        [[%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}]] ..
        [[%{% &busy > 0 ? '[BUSY] ' : '' %}]] ..
        [[%{% luaeval('(package.loaded[''vim.diagnostic''] and next(vim.diagnostic.count()) and vim.diagnostic.status() .. '' '') or '''' ') %} ]] ..
        [[%{% &ruler ? ( &rulerformat == '' ? '%-14.(%y %l,%c%V%) %P' : &rulerformat ) : '' %} ]]

    vim.opt.statusline = custom_statusline
end

do
    --------------------
    -- vim.diagnostic --
    --------------------

    local status = {}
    -- if false then
    --     local hl_map = {
    --         [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    --         [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
    --         [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
    --         [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
    --     }
    --     local signs = {
    --         [vim.diagnostic.severity.ERROR] = 'E',
    --         [vim.diagnostic.severity.WARN]  = 'W',
    --         [vim.diagnostic.severity.INFO]  = 'I',
    --         [vim.diagnostic.severity.HINT]  = 'H',
    --     }
    --
    --     status = {
    --         --- @param counts table<vim.diagnostic.Severity,integer>
    --         --- @return string
    --         format = function(counts)
    --             if next(counts) == nil then
    --                 return ""
    --             end
    --             local items = {}
    --             for level, _ in ipairs(vim.diagnostic.severity) do
    --                 local count = counts[level] or 0
    --                 if count > 0 then
    --                     -- table.insert(items, ("%%#%s#%s%%##:%s"):format(hl_map[level], signs[level], count))
    --                     table.insert(items, ("%%#%s#%s%%##%s"):format(hl_map[level], signs[level], count))
    --                 end
    --             end
    --             return table.concat(items, " ")
    --         end
    --     }
    -- end

    vim.diagnostic.config({
        jump = {
            -- float = true,
            on_jump = function(_, bufnr)
                vim.diagnostic.open_float({
                    bufnr = bufnr,
                    scope = 'cursor',
                    focus = false,
                })
            end,
            update_in_insert = false
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = 'E',
                [vim.diagnostic.severity.WARN]  = 'W',
                [vim.diagnostic.severity.INFO]  = 'I',
                [vim.diagnostic.severity.HINT]  = 'H',
            },
        },
        status = status,
    })
end
