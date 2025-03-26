vim.opt.guicursor      = "a:block"
vim.opt.updatetime     = 50
vim.opt.timeoutlen     = 500

vim.opt.encoding       = 'utf-8'
vim.opt.is             = true
vim.opt.showmode       = false
vim.opt.compatible     = false
vim.opt.number         = true
vim.opt.spell          = false
vim.opt.showcmd        = false
vim.opt.ruler          = false
vim.opt.cursorcolumn   = true
vim.opt.cursorline     = true
vim.opt.hlsearch       = false
vim.opt.incsearch      = true
vim.opt.cmdheight      = 1
vim.opt.foldmethod     = 'manual'
vim.opt.foldlevel      = 99
vim.opt.scrolloff      = 8
vim.opt.wildmenu       = true
vim.opt.shell          = "zsh"
vim.opt.relativenumber = true
vim.opt.colorcolumn    = "80"
vim.opt.textwidth      = 79
vim.opt.splitbelow     = true
vim.opt.splitright     = true
vim.opt.laststatus     = 3

local indent           = 2
vim.opt.tabstop        = indent
vim.opt.shiftwidth     = indent
vim.opt.foldcolumn     = "1"
vim.opt.expandtab      = true
vim.opt.linespace      = 0
vim.opt.history        = 1000
vim.opt.lbr            = true
vim.opt.smartindent    = true
vim.opt.conceallevel   = 2
vim.opt.concealcursor  = "c"

vim.opt.showbreak      = "↪"
vim.opt.list           = true
vim.opt.listchars      = {
    tab = '» ',
    extends = '›',
    precedes = '‹',
    nbsp = '·',
    trail = '·',
    -- eol = '¬'
}
vim.opt.mouse          = "a"

vim.cmd([[
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
]])

-- WHITESPACE
vim.api.nvim_create_autocmd({ "BufWritePre" }, { command = "%s/\\s\\+$//e" })

-- COMPILER
vim.g.rust_recommended_style = 0
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.rs", "Cargo.toml", "Cargo.lock" }, command = "compiler cargo" })

vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    {
        pattern = { "*.rs", "Cargo.toml", "Cargo.lock", "*.lua" },
        callback = function()
            vim.opt.tabstop    = 4
            vim.opt.shiftwidth = 4
        end
    })

vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    {
        pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.mjs", "*.cjs" },
        callback = function()
            vim.opt.tabstop    = 2
            vim.opt.shiftwidth = 2
        end
    })
