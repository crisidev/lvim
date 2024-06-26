local M = {}

M.config = function()
    -- Lsp config
    require("lvim.lsp.manager").setup("golangci_lint_ls", {
        on_init = require("lvim.lsp").common_on_init,
        capabilities = require("lvim.lsp").common_capabilities(),
    })

    local opts = {
        settings = {
            gopls = {
                gofumpt = true, -- A stricter gofmt
                codelenses = {
                    gc_details = true, -- Toggle the calculation of gc annotations
                    generate = true, -- Runs go generate for a given directory
                    regenerate_cgo = true, -- Regenerates cgo definitions
                    test = true,
                    tidy = true, -- Runs go mod tidy for a module
                    upgrade_dependency = true, -- Upgrades a dependency in the go.mod file for a module
                    vendor = true, -- Runs go mod vendor for a module
                },
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
                diagnosticsDelay = "500ms",
                symbolMatcher = "fuzzy",
                completeUnimported = true,
                staticcheck = true,
                matcher = "Fuzzy",
                usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
                analyses = {
                    fieldalignment = true, -- find structs that would use less memory if their fields were sorted
                    nilness = true, -- check for redundant or impossible nil comparisons
                    shadow = true, -- check for possible unintended shadowing of variables
                    unusedparams = true, -- check for unused parameters of functions
                    unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
                },
            },
        },
        on_attach = function(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end
            require("lvim.lsp").common_on_attach(client, bufnr)
            local _, _ = pcall(vim.lsp.codelens.refresh)
        end,
    }

    require("lvim.lsp.manager").setup("gopls", opts)
end

M.build_tools = function()
    local icons = require "user.icons"
    local which_key = require "which-key"
    local opts = {
        mode = "n",
        prefix = "f",
        buffer = vim.fn.bufnr(),
        silent = true,
        noremap = true,
        nowait = true,
    }
    local mappings = {
        B = {
            name = icons.languages.go .. " Build helpers",
            i = { "<cmd>GoInstallDeps<cr>", "Install dependencies" },
            t = { "<cmd>GoMod tidy<cr>", "Tidy" },
            a = { "<cmd>GoTestAdd<cr>", "Add test" },
            A = { "<cmd>GoTestsAll<cr>", "Add all tests" },
            e = { "<cmd>GoTestsExp<cr>", "Add exported tests" },
            g = { "<cmd>GoGenerate<cr>", "Generate" },
            c = { "<cmd>GoCmt<cr>", "Comment" },
            d = { "<cmd>lua require('dap-go').debug_test()<cr>", "Debug test" },
        },
    }
    which_key.register(mappings, opts)
end

return M
