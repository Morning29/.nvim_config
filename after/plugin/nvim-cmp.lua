local cmp = require("cmp")

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', option = { show_autosnippets = true } },
        { name = 'path' },
    },
    ---
    experimental = {
        ghost_text = true
    },
    ---
    window = {
        completion = {
            winblend = 20,
            max_height = 80,
        },
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
                nvim_lsp = "[LSP] ",
                nvim_lua = "[vim]",
                path = "[pth]",
                luasnip = "[snp]",
            })[entry.source.name] or "[?]   "
            ) .. item.menu
            return item
        end,
    },
    ---
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true })
        }),
        ["<Tab>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
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
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
        }),
    },
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
    formatting = {
        format = function(entry, item)
            item.menu = ({ cmdline = "[cmd]", path = "[path]" })[entry.source.name] or ""
            return item
        end,
    },
})
