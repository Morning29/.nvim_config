local cmp = require("cmp")
local luasnip = require("luasnip")
local compare = require('cmp.config.compare')

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    view = {
        entries = "custom" -- can be "custom", "wildmenu" or "native"
    },
    sources = {
        {
            name = 'nvim_lsp',
            -- entry_filter = function(entry, ctx)
            -- local kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Keyword'
            -- return kind ~= 'Text'
            -- return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Keyword'
            -- end
        },
        -- { name = 'nvim_lua' },
        { name = 'luasnip', option = { show_autosnippets = true } },
        { name = 'path' },
        {
            name = 'spell',
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
                preselect_correct_word = true,
            },
        },
        {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
    },
    ---
    experimental = {
        ghost_text = false
    },
    ---
    window = {
        completion = {
            winblend = 20,
            max_height = 80,
        },
    },
    ---
    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset,
            compare.exact,
            -- compare.scopes,
            compare.score,
            compare.recently_used,
            compare.length,
            compare.locality,
            compare.kind,
            compare.sort_text,
            -- compare.length,
            compare.order,
        },
    },
    ---
    performance = {
        debounce                 = 60,
        throttle                 = 30,
        fetching_timeout         = 500,
        filtering_context_budget = 3,
        confirm_resolve_timeout  = 80,
        async_budget             = 1,
        max_view_entries         = 50, -- 200,
    },
    ---
    formatting = {
        format = function(entry, item)
            if item.menu then
                item.menu = " " .. item.menu
            else
                item.menu = ""
            end
            item.menu = (({
                lazydev = "[lzy]",
                nvim_lsp = "[lsp]",
                -- nvim_lua = "[vim]",
                path = "[pth]",
                luasnip = "[snp]",
                spell = "[spl]",
            })[entry.source.name] or "[?]  ") -- .. item.menu
            -- if string.len(item.menu) >= 50 then
            --     item.menu = string.sub(item.menu, 1, 49) .. "…"
            -- end
            return item
        end,
    },

    ---
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    ---
    mapping = {
        ["<Down>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end, { "i" }),
        ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end, { "i" }),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    if cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    else
                        fallback()
                    end
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true })
        }),
        ["<Tab>"] = cmp.mapping({
            i = function(fallback)
                if luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                elseif cmp.visible() then
                    local entry = cmp.get_selected_entry()
                    if not entry then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    end
                    cmp.confirm()
                else
                    fallback()
                end
            end,
            -- i = function(fallback)
            --     if cmp.visible() and cmp.get_active_entry() then
            --         cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            --     else
            --         fallback()
            --     end
            -- end,
            s = cmp.mapping.confirm({ select = true }),
        }),
    },
})

cmp.setup.cmdline(":", {
    preselect = cmp.PreselectMode.None,
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end, { "c" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
                fallback()
            end
        end, { "c" }),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_selected_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
    },
    sources = cmp.config.sources(
        { { name = "path" }, },
        { { name = "cmdline" }, }
    ),
    formatting = {
        format = function(entry, item)
            item.menu = ({ cmdline = "[cmd]", path = "[pth]" })[entry.source.name] or "[?]"
            return item
        end,
    },
})
