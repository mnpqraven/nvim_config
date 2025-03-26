local wk = require('which-key')

wk.add({
    { "<leader>d", function() require('neogen').generate() end, desc = "Create documentation" },
})
