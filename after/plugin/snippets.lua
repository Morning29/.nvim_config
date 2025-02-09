local ls = require("luasnip")

local function trim(s)
    return s:match '^()%s*$' and '' or s:match '^%s*(.*%S)'
end

local todo = function()
    local fmt = string.format("TODO (Uebel %s): ", trim(os.date("%e/%h/%Y")))
    local cmt = vim.bo.commentstring
    if not string.match(cmt, " ") then
        fmt = " " .. fmt
    end
    return string.format(cmt, fmt)
end

ls.add_snippets(nil, {
    all = {
        ls.snippet({
            trig = "todo",
            namr = "todo",
            -- dscr = "Todo with name/date."
        }, {
            ls.function_node(todo, {}),
            ls.insert_node(1, ""),
        })
    }
})


