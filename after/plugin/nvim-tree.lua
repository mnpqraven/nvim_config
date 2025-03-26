local nmap = require('user.functions').nmap

nmap('<C-\\>', '<cmd>NvimTreeToggle<CR>')

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings

    nmap("<C-e>", "<cmd>:wincmd l<CR>", opts(""))
    nmap("e", function() end, opts(""))
    nmap("<C-n>", api.node.open.tab, opts("Edit in new tab"))
    nmap("<CR>", api.node.open.edit, opts("Edit"))
    nmap("<C-o>", api.node.open.edit, opts("Edit"))
    nmap("o", api.node.open.edit, opts("Edit"))
    nmap("<2-LeftMouse>", api.node.open.edit, opts("Edit"))
end

require("nvim-tree").setup({
    on_attach = my_on_attach,
    view = {
        width = 35,
    },
    renderer = {
        icons = {
            glyphs = {
                git = {
                    unstaged = "",
                    -- staged = "✓",
                    -- unmerged = "",
                    -- renamed = "➜",
                    untracked = "",
                    -- deleted = "",
                    -- ignored = "◌",
                },
            },
        },
        indent_markers = {
            enable = true
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
    },
})
