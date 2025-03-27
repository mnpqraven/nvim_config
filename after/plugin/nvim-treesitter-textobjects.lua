require 'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Around function" },
                ["if"] = { query = "@function.inner", desc = "Inside function" },
                ["ac"] = { query = "@class.outer", desc = "Around class" },
                ["ic"] = { query = "@class.inner", desc = "Inside class" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V',  -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>p"] = "@parameter.inner"
            },
            swap_previous = {
                ["<leader>P"] = "@parameter.inner"
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
                ["]o"] = "@loop.*",
                ["]s"] = { query = "@scope", query_group = "locals" },
                ["]z"] = { query = "@fold", query_group = "folds" },
                ["]a"] = "@parameter.inner"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
                ["[o"] = "@loop.*",
                ["[s"] = { query = "@scope", query_group = "locals" },
                ["[z"] = { query = "@fold", query_group = "folds" },
                ["[a"] = "@parameter.inner"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
            goto_next = {
                ["]d"] = "@condotional.outer"
            },
            goto_previous = {
                ["[d"] = "@condotional.outer"
            },
        }
    },
}

require 'treesitter-context'.setup {
    max_lines = 5,
}
