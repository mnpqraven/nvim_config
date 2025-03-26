-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
-- local symbols = require('user.constants')
local lsp = require('lsp-zero')
local rt = require("rust-tools")
local wk = require('which-key')
local crates = require('crates')

lsp.preset('lsp-compe')
lsp.skip_server_setup({ 'rust_analyzer' })

-- TODO:
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

lsp.ensure_installed({
    'lua_ls',
    'ts_ls',
    'eslint',
    'rust_analyzer',
    'taplo',
    'tailwindcss',
    'cssls',
    'cssmodules_ls'
})

lsp.on_attach(function(_, bufnr)
    require('lsp_signature').on_attach({
        bind = true,
        handler_opts = { border = "single" },
        hint_prefix = "> "
    }, bufnr)

    wk.add({
        { "g",                group = "Go" },
        { "gd",               vim.lsp.buf.definition,      desc = "Go to definition" },
        { "gD",               vim.lsp.buf.declaration,     desc = "Go to declaration" },
        { "gr",               vim.lsp.buf.references,      desc = "List references" },
        { "K",                vim.lsp.buf.hover,           desc = "Hover" },
        { "<C-k>",            vim.lsp.buf.signature_help,  desc = "Signature help" },
        { "]d",               vim.diagnostic.goto_next,    desc = "Next diagnostic" },
        { "[d",               vim.diagnostic.goto_prev,    desc = "Previous diagnostic" },

        { "<leader>o",        vim.lsp.buf.format,          desc = "Format" },
        { "<leader>D",        vim.lsp.buf.type_definition, desc = "Go to type definition" },
        { "<leader>r",        group = "Rename" },
        { "<leader>rn",       vim.lsp.buf.rename,          desc = "Rename" },
        { "<leader>q",        group = "Quickfix" },
        { "<leader>qf",       vim.lsp.buf.code_action,     desc = "Code actions" },
        { "<leader><leader>", vim.diagnostic.open_float,   desc = "Open diagnostic window", }
    })
end)
lsp.configure('nil_ls', {
    settings = {
         ['nil'] = {
         formatting = {
            command = { "nixfmt" },
         },
      },
    }
})

lsp.configure('taplo', {
    -- TODO:
    on_attach = function(_, bufnr)
        wk.register({
            c = {
                name = "Cargo",
                u = { crates.update_crate, "Update crate", buffer = bufnr },
                U = { crates.upgrade_crate, "Upgrade crate", buffer = bufnr },
                a = { crates.upgrade_all_crates, "Upgrade all crates", buffer = bufnr },
                h = { crates.open_homepage, "Open homepage", buffer = bufnr },
                d = { crates.open_documentation, "Open documentation", buffer = bufnr },
            }
        }, { prefix = "<leader>" })
    end
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('tailwindcss', {
    on_attach = function(_, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
    end,
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    { "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                },
            },
        },
    },
})

lsp.configure('cssmodules_ls', {
    on_attach = function(client)
        client.server_capabilities.definitionProvider = false
    end,
    init_options = {
        camelCase = false
    }
})

local rust_lsp = lsp.build_options('rust_analyzer', {
    on_attach = function(_, bufnr)
        -- TODO:
        wk.register({
            K = { rt.hover_actions.hover_actions, "Hover actions", buffer = bufnr },
        })
        wk.register({
            c = {
                name = "cargo",
                r = { rt.runnables.runnables, "Cargo actions", buffer = bufnr }
            },
        }, { prefix = "<leader>" })
        -- Code action groups
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                extraArgs = { "--all", "--", "-W", "clippy::all" },
            },
        }
    }
})

lsp.setup()

-- Initialize rust_analyzer with rust-tools
require('rust-tools').setup({
    server = rust_lsp,
    tools = {
        inlay_hints = {
            auto = false
        }
    }
})
