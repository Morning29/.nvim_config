local ls = require("luasnip")

local function trim(s)
    return s:match '^()%s*$' and '' or s:match '^%s*(.*%S)'
end

local todo_keyword = function(keyword)
    local fmt = string.format("%s %s HSU: ", keyword, trim(os.date("%d/%m/%y")))
    local cmt = vim.bo.commentstring
    if not string.match(cmt, " ") then
        fmt = " " .. fmt
    end
    return string.format(cmt, fmt)
end

local TODO = function()
    return todo_keyword("TODO")
end

local RESUME = function()
    return todo_keyword("RESUME")
end

ls.add_snippets(nil, {
    all = {
        ls.snippet({
            trig = "todo",
            namr = "todo",
            -- dscr = "Todo with name/date."
        }, {
            ls.function_node(TODO, {}),
            ls.insert_node(1, ""),
        }),
        ls.snippet({
            trig = "todo_resume",
            namr = "resume",
            -- dscr = "Todo with name/date."
        }, {
            ls.function_node(RESUME, {}),
            ls.insert_node(1, ""),
        })
    }
})
