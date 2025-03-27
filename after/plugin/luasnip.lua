local ls = require("luasnip")

-- extends to supersets
ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
-- require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/vscode_snippets/"})
