local luasnip = require("luasnip")

do
    local types = require("luasnip.util.types")
    luasnip.setup({
        update_events = {
            'TextChanged',
            'TextChangedI',
        },
        ext_opts = {
            -- [types.insertNode] = {
            --     -- these ext_opts are applied when the node is active (e.g. it has been jumped into, and not out yet).
            --     active = { hl_group = "Visual" },
            --     -- these ext_opts are applied when the node is not active, but the snippet still is.
            --     passive = {},
            --     -- visited or unvisited are applied when a node was/was not jumped into.
            --     visited = {},
            --     unvisited = { virt_text = { { "<", "MoreMsg" } }, },
            --     -- and these are applied when both the node and the snippet are inactive.
            --     snippet_passive = {}
            -- },
            -- [types.functionNode] = {},
            -- [types.snippetNode] = {},
            -- [types.choiceNode] = {},
            -- [types.dynamicNode] = {},
            -- [types.snippet] = {},
            [types.exitNode] = {
                unvisited = {
                    virt_text = { { "<", "Blink" } },
                }
            },
            -- [types.restoreNode] = {},
        }
    })
end

do
    local all_snips = {}

    do
        local todo_snippet_keywords = {
            ["TODO"]     = 9,
            ["NOTE"]     = 7,
            ["NOCOMMIT"] = 6,
            ["RESUME"]   = 6,
            ["HACK"]     = 3,
            ["WARNING"]  = 2,
            [""]         = 0,
            ["PERF"]     = 0,
            ["FIXME"]    = 0,
        }

        for keyword, priority in next, todo_snippet_keywords do
            local kw_padded = " " .. keyword:gsub("%S$", "%0 ")
            table.insert(all_snips,
                luasnip.snippet({
                    trig = ("todo " .. keyword):gsub(" TODO", ""):gsub(" $", " (Date only)"),
                    desc = "dated" .. kw_padded .. "comment",
                    priority = 1000 + 100 * priority
                }, {
                    luasnip.function_node(function()
                        return vim.bo.cms:gsub(" *%%s$", kw_padded) .. os.date("%d/%m/%y HSU: ")
                    end, {}),
                    luasnip.insert_node(0),
                })
            )
        end
    end

    do
        local oddname_types = { "string", "cstring", "[]u8", "[]byte", "[]rune", }

        for _, type in next, oddname_types do
            local base_type, list_matches = type:gsub("%[%]", "")

            local nodes = { luasnip.text_node("name: ") }
            if list_matches > 0 then
                table.insert(nodes, luasnip.text_node("["))
                table.insert(nodes, luasnip.insert_node(0))
                table.insert(nodes, luasnip.text_node("]"))
            end
            table.insert(nodes, luasnip.text_node(base_type .. ' `odd:"named_by"`,'))

            table.insert(all_snips,
                luasnip.snippet({
                    filetype = "odin",
                    trig = ("oddname " .. type):gsub("cstring", "cstr"):gsub(" string", ""),
                    desc = "Odin `" .. type .. "`-typed name struct field with `odd:\"named_by\"` annotation",
                }, nodes)
            )
        end
    end

    do
        local opt = require("luasnip.nodes.optional_arg").new_opt
        local k = require("luasnip.nodes.key_indexer").new_key

        --- @param filetype string
        --- @param cmt_str string
        local add_section_comment_snip = function(filetype, cmt_str)
            local comment_section_head_and_foot = function(args, parent, user_args)
                local cmt_str_len = cmt_str:len()
                local body_len = args[1][1]:len() + (cmt_str_len + 1) * 2
                local reps = 1 + body_len / cmt_str_len
                return string.rep(cmt_str, reps):sub(1, body_len)
            end

            --- @param str string
            --- @return string
            local capitalize = function(str)
                local s = str:gsub("^.", string.upper)
                return s
            end

            local section_string = "section indicator comment (" .. capitalize(filetype) .. ")."

            table.insert(all_snips, luasnip.snippet({
                filetype = filetype,
                trig = ("Section Comment (UPPER)"),
                desc = "Capitalized code " .. section_string,
            }, {
                luasnip.dynamic_node(1,
                    function(args)
                        -- TODO 23/10/26 HSU: This will be fucked in some langs.
                        local upper_text = args[1] and args[1]:upper() or ""

                        return luasnip.snippet_node(0, {
                            luasnip.function_node(comment_section_head_and_foot, { 1 }),
                            luasnip.text_node({ "", cmt_str .. " " }),
                            luasnip.insert_node(1, upper_text, { key = "ins" }),
                            luasnip.text_node({ " " .. cmt_str, "" }),
                            luasnip.function_node(comment_section_head_and_foot, { 1 }),
                            luasnip.text_node({ "", "" }),
                        })
                    end,
                    { opt(k("ins")) }, { snippetstring_args = true }
                )
            }))

            table.insert(all_snips, luasnip.snippet({
                -- TODO 23/10/26 HSU: Not just odin...
                filetype = filetype,
                trig = ("Section Comment"),
                desc = "Code " .. section_string,
            }, {
                luasnip.dynamic_node(1,
                    function(args)
                        local text = args[1] or ""

                        return luasnip.snippet_node(0, {
                            luasnip.function_node(comment_section_head_and_foot, { 1 }),
                            luasnip.text_node({ "", cmt_str .. " " }),
                            luasnip.insert_node(1, text, { key = "ins" }),
                            luasnip.text_node({ " " .. cmt_str, "" }),
                            luasnip.function_node(comment_section_head_and_foot, { 1 }),
                            luasnip.text_node({ "", "" }),
                        })
                    end,
                    { opt(k("ins")) }, { snippetstring_args = true }
                )
            }))
        end

        add_section_comment_snip("odin", "//")
        add_section_comment_snip("slang", "//")
        add_section_comment_snip("c", "//")
        add_section_comment_snip("cpp", "//")
        add_section_comment_snip("lua", "--")
    end

    luasnip.add_snippets(nil, { all = all_snips })
end
