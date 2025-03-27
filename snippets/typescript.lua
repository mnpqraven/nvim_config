---@diagnostic disable: undefined-global

return {
    s('callback', {
        t { '(' }, i(1),
        t { ') => ' }, i(2)
    }),
    s('setState', {
        t('const ['), i(1, 'state'), t(', set'),
        l(l._1:gsub('^%l', string.upper), 1),
        t('] = useState('), i(2),
        t(');')
    }),
    s('useEffect', {
        t { 'useEffect(() => {', '  ' }, i(1),
        t { '', '' },
        t('}, ['), i(2),
        t { ']);', '' }
    }),
    s('useCallback', {
        t('const '), i(1),
        t { ' = useCallback((' }, i(2, 'args'), t { ') => {', '' },
        i(3), t { '', '' },
        t('}, ['), i(4),
        t { ']);', '' }
    }),
    postfix('.tsx', {
        f(function(_, parent)
            return "<" .. parent.snippet.env.POSTFIX_MATCH .. " />"
        end), t { '', '' }
    }),
    s('invoke', {
        t('invoke'), i(1), t('(\''), i(2), t('\', {'),
        i(2), t('}'),
        t(')')
    })
}
