local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local lspkind = require('lspkind')
local ls = require('luasnip')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp_mapping = lsp.defaults.cmp_mappings({
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif ls.expandable() then
            ls.expand()
        elseif ls.expand_or_jumpable() then
            ls.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif ls.jumpable(-1) then
            ls.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true })
})

-- cmp_mapping['<Tab>'] = nil

local square = { '┌', "─", "┐", '│', "┘", "─", "└", "│" }
local cmp_configs = lsp.defaults.cmp_config({
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
        completion = {
            border = square,
            col_offset = -5,
        },
        documentation = {
            border = square
        }
    },
    mapping = cmp_mapping,
    sources = {
        { name = 'luasnip',  keyword_length = 1 },
        { name = 'nvim_lsp', keyword_length = 2 },
        { name = 'crates' },
    },
    {
        { name = 'buffer' },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            menu = {}
        })
    }
})

cmp.event:on(
    'confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.filetype('norg', {
    sources = cmp.config.sources({
        { name = 'neorg' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
cmp.setup(cmp_configs)
