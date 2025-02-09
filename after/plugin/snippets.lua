local ls = require("luasnip")

local function trim(s)
    return s:match '^()%s*$' and '' or s:match '^%s*(.*%S)'
end

local todo = function()
    local fmt = string.format("TODO %s HSU: ", trim(os.date("%d/%m/%y")))
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


