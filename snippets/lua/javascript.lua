---@diagnostic disable: undefined-global
--
return {
    s('ternary', {
        i(1, 'cond'), t(' ? '), i(2, 'then'), t(' : '), i(3, 'else')
    }),
    s('initComponent', {
        t { 'const ' }, i(1),
        t { ' = () => {', '' },
        t { '  return (', '' },
        t { '    <>', '      ' }, i(2), t { '', '' },
        t { '    </>', '' },
        t { '  );', '' },
        t { '};', '' }, t { 'export default ' }, rep(1), t { ';' }
    })
}
