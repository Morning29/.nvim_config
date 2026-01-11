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

local TODO = function() return todo_keyword("TODO") end
local RESUME = function() return todo_keyword("RESUME") end
local NOTE = function() return todo_keyword("NOTE") end
local HACK = function() return todo_keyword("HACK") end
local PERF = function() return todo_keyword("PERF") end
local FIXME = function() return todo_keyword("FIXME") end
local WARN = function() return todo_keyword("WARNING") end
local NOCOMMIT = function() return todo_keyword("NOCOMMIT") end

local snippet_datas = {
    { trig = "todo",          namr = "todo comment",     fun_node = TODO },
    { trig = "todo_resume",   namr = "resume comment",   fun_node = RESUME },
    { trig = "todo_note",     namr = "note comment",     fun_node = NOTE },
    { trig = "todo_hack",     namr = "hack comment",     fun_node = HACK },
    { trig = "todo_perf",     namr = "perf comment",     fun_node = PERF },
    { trig = "todo_fixme",    namr = "fixme comment",    fun_node = FIXME },
    { trig = "todo_warning",  namr = "warning comment",  fun_node = WARN },
    { trig = "todo_nocommit", namr = "nocommit comment", fun_node = NOCOMMIT },
}

local all_snips = {}

for _, data in pairs(snippet_datas) do
    table.insert(all_snips,
        ls.snippet({
            trig = data.trig,
            namr = data.namr,
        }, {
            ls.function_node(data.fun_node, {}),
            ls.insert_node(1, ""),
        })
    )
end

ls.add_snippets(nil, { all = all_snips })
