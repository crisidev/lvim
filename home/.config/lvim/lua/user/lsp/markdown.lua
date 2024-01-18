local M = {}

M.grammar_guard = function()
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

M.marksman = function()
    require("lspconfig").marksman.setup {}
end

M.config = function()
    M.grammar_guard()
    M.marksman()
end

return M
