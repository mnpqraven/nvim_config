---@diagnostic disable: undefined-global
local expr_pattern = "[%:%w%<%(%)$>%.%_%-%\"%']+$"
-- TODO: better logic, start with js
-- print(string.match("test var(Arc:Some(x).", expr_pattern))
-- print(string.match("test var2(Arc::Some(x).", expr_pattern))
-- print(string.match("test var2(Arc:::Some(x).", expr_pattern))
-- print(string.match("test Option<Ok(t)>.", expr_pattern))

local rec_pl
rec_pl = function()
    return sn(nil, {
        c(1, {
            t({ "" }),
            sn(nil, { t({ " {}" }), i(1), d(2, rec_pl, {}) }),
        })
    })
end
local rec_pl_q
rec_pl_q = function()
    return sn(nil, {
        c(1, {
            t({ "" }),
            sn(nil, { t({ " {:?}" }), i(1), d(2, rec_pl_q, {}) }),
        })
    })
end

return {
    -- Option<[[]]*>
    postfix({ trig = ".option", match_pattern = "[%<%>%(%)%w%.%_%-]+$" },
        {
            f(function(_, parent)
                return "Option<" .. parent.snippet.env.POSTFIX_MATCH .. ">"
            end, {}),
        }),
    -- Vec<[[]]>*
    postfix({ trig = ".vec", match_pattern = "[%<%>%(%)%w%.%_%-]+$" },
        {
            f(function(_, parent)
                return "Vec<" .. parent.snippet.env.POSTFIX_MATCH .. ">"
            end, {}),
        }),

    -- println!("{}", *);
    s("pl", {
        t({ "println!(\"{}" }), i(1), d(2, rec_pl, {}),
        t({ "\", " }), i(3), t({ ")" }),
    }),

    -- println!("{:?}", *);
    s("pl?", {
        t({ "println!(\"{:?}" }), i(1), d(2, rec_pl_q, {}),
        t({ "\", " }), i(3), t({ ")" }),
    }),

    -- println!("{:?}", *);
    s(".pl?", {
        t({ "println!(\"{:?}" }), i(1), d(2, rec_pl_q, {}),
        t({ "\", " }), i(3), t({ ")" }),
    }),

    -- println!("{}", *);
    postfix(".pl", {
        f(function(_, parent)
            return "println!(\"{}\", " .. parent.snippet.env.POSTFIX_MATCH .. ");"
        end, {}),
    }),

}
