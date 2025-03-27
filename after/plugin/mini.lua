require('mini.bracketed').setup()
require('mini.ai').setup()
require('mini.surround').setup({
    mappings = {
        add = 'ys',
        delete = 'ds',
        replace = 'cs',
        find = 'yf',
        find_left = 'yF',
        highlight = 'yh',
        update_n_lines = 'yn',
    },
    n_lines = 1000
})
require('mini.pairs').setup()
require('mini.diff').setup({
    view = {
        style = 'sign'
    }
})
require('mini.hipatterns').setup()
require('mini.notify').setup()
require('mini.splitjoin').setup()
require('mini.cursorword').setup()

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

require('mini.move').setup({
    mappings = {
        left = '<left>',
        right = '<right>',
        down = '<down>',
        up = '<up>',
        line_left = '<left>',
        line_right = '<right>',
        line_down = '<down>',
        line_up = '<up>',
    },
})
require('mini.align').setup()
require('mini.bufremove').setup()
