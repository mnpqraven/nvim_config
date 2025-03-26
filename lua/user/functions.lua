local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.map      = bind("", { noremap = false })
M.noremap  = bind("", { noremap = true })
M.nmap     = bind("n", { noremap = false })
M.vmap     = bind("v", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("c")
M.inoremap = bind("i")

return M
