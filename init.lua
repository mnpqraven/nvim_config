require("othi")

vim.opt.termguicolors = true

-- NOTE: PACKAGE MANAGER
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- TODO: tabout key
require('lazy').setup({
    -- NOTE: SYNTAX ----------------------------------------------------------
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    'nvim-telescope/telescope-ui-select.nvim',

    -- NOTE: THEME -----------------------------------------------------------
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'nvim-tree/nvim-tree.lua',
        version = "*",
        lazy = false
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-context',
            'JoosepAlviste/nvim-ts-context-commentstring',
        }
    },
    {
        'echasnovski/mini.nvim',
        version = false,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function()
            require('ibl').setup()
        end
    },
    {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup({
                handle = { blend = 0 }
            })
        end
    },
    'nvim-lualine/lualine.nvim',
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Specific languagess
            { 'simrat39/rust-tools.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            {
                'L3MON4D3/LuaSnip',
                version = "2.*",
                build = "make install_jsregexp"
            },
        }
    },
    'MunifTanjim/prettier.nvim',
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end
    },
    {
        'laytan/tailwind-sorter.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        config = true,
    },
    'mfussenegger/nvim-dap',
    {
        'saecki/crates.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    },
    'tpope/vim-fugitive',
    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup({
                signs = false
            })
        end
    },
    'abecodes/tabout.nvim',
    -- LOCALE
    'rlue/vim-barbaric',
    {
        "danymat/neogen",
        config = function()
            require('neogen').setup({ snippet_engine = 'luasnip' })
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    'mattn/emmet-vim',
    'onsails/lspkind.nvim',
    'ray-x/lsp_signature.nvim',
    {
        'folke/trouble.nvim',
        config = function()
            require("trouble").setup {
                height = 7
            }
        end,
    },
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        opts = {
            outline_window = {
                width = 15,
            },
            keymaps = {
                unfold = "e",
                fold_all = "H"
            },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            input = {
                enabled = true
                -- your input configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        }
    },
    {
        'themaxmarchuk/tailwindcss-colors.nvim',
        module = "tailwindcss-colors",
        config = function()
            require("tailwindcss-colors").setup()
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    {
        'ziontee113/icon-picker.nvim',
        config = function()
            require("icon-picker").setup {
                disable_legacy_commands = true
            }
        end
    },
    {
        'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'
    },
    'lervag/vimtex',
    'nvimtools/none-ls.nvim',
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
            require('hop').setup {
                keys = 'arsdheiqwfpgjluyozxcvbkmtn'
            }
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        "keaising/im-select.nvim",
        config = function()
            -- require("im_select").setup({
            --     default_im_select = "keyboard-us",
            --     default_command = "fcitx5-remote",
            -- })
        end,
    }
})
