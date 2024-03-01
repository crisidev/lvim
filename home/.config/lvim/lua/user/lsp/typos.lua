local M = {}

M.config = function()
    require("lspconfig").typos_lsp.setup {
        init_options = {
            diagnosticSeverity = "Hint",
        },
    }
end

return M
