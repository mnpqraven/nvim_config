local map = require("user.functions").map
local nmap = require("user.functions").nmap
local nnoremap = require("user.functions").nnoremap
local inoremap = require("user.functions").inoremap

map('N', 'K')
map('n', 'gj')
map('E', 'J')
map('e', 'l')
map('k', 'nzz')
map('K', 'Nzz')
map('l', 'gk')
map('E', '$')
map('H', '0')
map('N', 'L')

map('<C-d>', '<C-d>zz')

-- split navigation
nmap('<C-h>', '<cmd>:wincmd h<CR>')
nmap('<C-n>', '<cmd>:wincmd j<CR>')
nmap('<C-e>', '<cmd>:wincmd l<CR>')
nmap('<C-l>', '<cmd>:wincmd k<CR>')

-- tab navigation
nmap('<leader>1', '1gt')
nmap('<leader>2', '2gt')
nmap('<leader>3', '3gt')
nmap('<leader>4', '4gt')
nmap('<leader>5', '5gt')
nmap('<leader>6', '6gt')
nmap('<leader>7', '7gt')
nmap('<leader>8', '8gt')
nmap('<leader>9', '9gt')

nmap('<C-w>', '<cmd>bd<CR>')
nmap('<C-s>', '<cmd>:w!<CR>')
nmap('<F8>', '<cmd>set hlsearch! hlsearch?<CR>')

-- Leader keys
nnoremap('<Leader>k', '<cmd>tabnext<CR>')
nnoremap('<Leader>K', '<cmd>tabprevious<CR>')
nnoremap('<Leader>cd', '<cmd>cd %:p:h<CR> <cmd>pwd<CR><left>')
nnoremap('<Leader>c', '<cmd>%y+<CR>')
nnoremap('<silent><Leader>s', '<cmd>setlocal spell! spelllang=en_US<CR><ESC>')
nmap('z<tab>', 'zf%')

-- buffer navigation
nnoremap('<C-A-e>', '<cmd>bn<CR>')
nnoremap('<C-A-h>', '<cmd>bp<CR>')

-- split resizing
nmap('<A-l>', '<cmd>res +5<CR>')
nmap('<A-n>', '<cmd>res -5<CR>')
nmap('<A-h>', '<cmd>vertical resize -5<CR>')
nmap('<A-e>', '<cmd>vertical resize +5<CR>')

nmap('G', 'Gzz')

-- tabbingout semicolon
inoremap(';;', ':')
inoremap(';K', ';<esc>')
inoremap(';e', ';<esc>a')
inoremap(';n', ';<esc>')
inoremap(';o', ';<esc>o')

nnoremap('<A-y>', '<C-e>')
nnoremap('<C-A-y>', '<C-y>')

-- CLIPBOARD
vim.cmd([[
inoremap <C-z> <ESC>l"+pi
nnoremap <C-z> "+P
vnoremap <C-c> "+y
]])
