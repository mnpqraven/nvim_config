require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "vim", "rust", "javascript", "typescript", "tsx", "css", "html", "json", "toml", "vue", "nix" },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    -- rainbow = {
    --     enable = true,
    --     extended_mode = true,
    --     max_file_lines = nil
    -- },
}
