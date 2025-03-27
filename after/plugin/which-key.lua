local wk = require('which-key')

wk.setup({
    preset = "modern",
    delay = 0,
})

wk.add({
    { "<leader>g",  "<cmd>G<CR>",             desc = "Open Git console" },
    { "<leader>h",  "<cmd>HopWord<CR>",       desc = "Hop" },
    { "<leader>s",  group = "Show" },
    { "<leader>ss", "<cmd>Outline<CR>",       desc = "Outline Symbols" },
    { "<leader>st", "<cmd>TroubleToggle<CR>", desc = "Diagnostic" },
})
