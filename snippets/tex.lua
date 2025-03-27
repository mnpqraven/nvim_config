---@diagnostic disable: undefined-global
local rec_ls = function()
    return sn(nil, {
        c(1, {
            -- important!! Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        }),
    });
end

local table_node = function(args)
    local tabs = {}
    local count
    table = args[1][1]:gsub("%s", ""):gsub("|", "")
    ---@diagnostic disable-next-line: undefined-field
    count = table:len()
    for j = 1, count do
        local iNode
        iNode = i(j)
        tabs[2 * j - 1] = iNode
        if j ~= count then
            tabs[2 * j] = t " & "
        end
    end
    return sn(nil, tabs)
end
local rec_table = function()
    return sn(nil, {
        c(1, {
            t({ "" }),
            sn(nil, { t { "\\\\", "" }, d(1, table_node, { ai[1] }), d(2, rec_table, { ai[1] }) })
        }),
    });
end

return {
    s("begin", {
        t({ "\\begin{" }), i(1), t({ "}", "" }),
        i(2), t({ "", "" }),
        t({ "\\end{" }), rep(1), t({ "}", "" })
    }),
    s("ls", {
        t({ "\\begin{itemize}",
            "\t\\item " }), i(1), d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }), i(0)
    }),
    s("table", {
        t "\\begin{tabular}{",
        i(1, "0"), t { "}", "" },
        d(2, table_node, { 1 }, {}), d(3, rec_table, { 1 }),
        t { "", "\\end{tabular}" }
    }),
    s("bf", {
        t({ "\\textbf{" }), i(1), t({ "}" })
    }),
    s("it", {
        t({ "\\textit{" }), i(1), t({ "}" })
    })
}
