local function trim(s)
    return s:match '^()%s*$' and '' or s:match '^%s*(.*%S)'
end

local todo_keyword = function(keyword)
    local fmt = string.format("%s HSU: ", trim(os.date("%d/%m/%y")))
    if keyword then
        fmt = string.format("%s %s", keyword, fmt)
    end
    local cmt = vim.bo.commentstring
    if not string.match(cmt, " ") then
        fmt = " " .. fmt
    end
    return string.format(cmt, fmt)
end

local COMMENT = function() return todo_keyword() end
local TODO = function() return todo_keyword("TODO") end
local RESUME = function() return todo_keyword("RESUME") end
local NOTE = function() return todo_keyword("NOTE") end
local HACK = function() return todo_keyword("HACK") end
local PERF = function() return todo_keyword("PERF") end
local FIXME = function() return todo_keyword("FIXME") end
local WARN = function() return todo_keyword("WARNING") end
local NOCOMMIT = function() return todo_keyword("NOCOMMIT") end

local todo_snippet_datas = {
    { trig = "todo",           namr = "TODO comment",     fun_node = TODO },
    { trig = "todo_only_date", namr = "DATED comment",    fun_node = COMMENT },
    { trig = "todo_resume",    namr = "RESUMe comment",   fun_node = RESUME },
    { trig = "todo_note",      namr = "NOTE comment",     fun_node = NOTE },
    { trig = "todo_hack",      namr = "HACK comment",     fun_node = HACK },
    { trig = "todo_perf",      namr = "PERF comment",     fun_node = PERF },
    { trig = "todo_fixme",     namr = "FIXME comment",    fun_node = FIXME },
    { trig = "todo_warning",   namr = "WARNING comment",  fun_node = WARN },
    { trig = "todo_nocommit",  namr = "NOCOMMIT comment", fun_node = NOCOMMIT },
}

local all_snips = {}

local luasnip = require("luasnip")
for _, data in pairs(todo_snippet_datas) do
    table.insert(all_snips,
        luasnip.snippet({
            trig = data.trig,
            namr = data.namr,
        }, {
            luasnip.function_node(data.fun_node, {}),
            luasnip.insert_node(1, ""),
        })
    )
end

table.insert(all_snips,
    luasnip.snippet({
        trig = "oddname",
        namr = "Odin name struct field with `odd:\"named_by\"` annotation",
    }, {
        luasnip.text_node("name: string `odd:\"named_by\"`,", {}),
        luasnip.text_node("", {}),
        luasnip.insert_node(1, ""),
    })
)

luasnip.add_snippets(nil, { all = all_snips })
