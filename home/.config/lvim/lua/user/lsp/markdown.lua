local M = {}

M.config = function()
    require("grammar-guard").init()
    local ok, grammarguard = pcall(require, "grammar-guard")
    if ok then
        grammarguard.init()
    end

    local opts = {
        cmd = { "ltex-ls" },
        filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
        root_dir = function(fname)
            return require("lspconfig").util.find_git_ancestor(fname) or vim.fn.getcwd()
        end,
        settings = {
            ltex = {
                checkFrequency = "save",
                enabled = { "latex", "tex", "bib", "markdown", "rst", "text" },
                language = "en-US",
                diagnosticSeverity = "information",
                sentenceCacheSize = 2000,
                additionalRules = {
                    enablePickyRules = true,
                    -- motherTongue = "it-IT",
                },
                trace = { server = "warning" },
            },
        },
        on_attach = require("lvim.lsp").common_on_attach,
        on_init = require("lvim.lsp").common_on_init,
        capabilities = require("lvim.lsp").common_capabilities(),
        single_file_support = true,
    }
    local status_ok, lsp = pcall(require, "lspconfig")
    if not status_ok then
        return
    end

    status_ok, lsp = pcall(lsp.grammar_guard.setup, opts)
    if not status_ok then
        return
    end
end

return M
