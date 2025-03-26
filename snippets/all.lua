---@diagnostic disable: undefined-global
return {
    s({
        trig = "date",
        namr = "Date",
        dscr = "Date in the form of DD-MM-YYYY",
    }, {
        f(function() return { os.date('%d-%m-%Y') } end, {}),
    }),
}
