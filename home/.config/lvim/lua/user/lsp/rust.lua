local M = {}

M.config = function()
    local opts = {
        tools = {
            executor = require "rustaceanvim.executors.termopen", -- can be quickfix or termopen
            reload_workspace_from_cargo_toml = true,
            hover_actions = {
                border = {
                    { "╭", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╮", "FloatBorder" },
                    { "│", "FloatBorder" },
                    { "╯", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╰", "FloatBorder" },
                    { "│", "FloatBorder" },
                },
                auto_focus = true,
            },
        },
        server = {
            on_attach = require("lvim.lsp").common_on_attach,
            on_init = require("lvim.lsp").common_on_init,
            capabilities = require("lvim.lsp").common_capabilities(),
            default_settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        enable = true,
                        command = "check",
                        -- target = "aarch64-unknown-linux-musl",
                        -- allTargets = false,
                    },
                    callInfo = {
                        full = true,
                    },
                    lens = {
                        enable = true,
                        references = true,
                        implementations = true,
                        enumVariantReferences = true,
                        methodReferences = true,
                    },
                    inlayHints = {
                        enable = true,
                        typeHints = true,
                        parameterHints = true,
                    },
                    cachePriming = {
                        enable = false,
                    },
                    diagnostics = {
                        experimental = true,
                    },
                    cargo = {
                        autoreload = true,
                        features = "all",
                        -- target = "aarch64-unknown-linux-musl",
                        buildScripts = {
                            enable = true,
                        },
                    },
                    hoverActions = {
                        enable = true,
                        references = true,
                    },
                    procMacro = {
                        enable = true,
                    },
                },
            },
        },
    }
    local path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/")
    local codelldb_path = path .. "adapter/codelldb"
    local liblldb_path = path .. "lldb/lib/liblldb.so"

    if vim.fn.has "mac" == 1 then
        liblldb_path = path .. "lldb/lib/liblldb.dylib"
    end

    if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
        local cfg = require "rustaceanvim.config"
        opts.dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        }
    else
        vim.notify("please reinstall codellb, cannot find liblldb or codelldb", vim.log.levels.WARN)
    end
    vim.g.rustaceanvim = function()
        return opts
    end
end

M.build_tools = function()
    local which_key = require "which-key"
    local icons = require "user.icons"
    local opts = {
        mode = "n",
        prefix = "f",
        buffer = vim.fn.bufnr(),
        silent = true,
        noremap = true,
        nowait = true,
    }
    local mappings = {
        K = { "<cmd>RustLsp externalDocs<cr>", icons.icons.docs .. "Open docs.rs" },
        L = { "<cmd>RustLsp renderDiagnostic<cr>", icons.icons.hint .. "Show cargo diagnostic" },
        B = {
            name = icons.languages.rust .. " Build helpers",
            A = {
                name = "Rust analyzer",
                s = { "<cmd>RustAnalyzer start<cr>", "Start" },
                S = { "<cmd>RustAnalyzer stop<cr>", "Stop" },
                r = { "<cmd>RustAnalyzer restart<cr>", "Restart" },
            },
            a = { "<cmd>RustLsp hover actions<cr>", "Hover actions" },
            r = { "<cmd>RustLsp runnables<cr>", "Run targes" },
            R = { "<cmd>RustLsp debuggables<cr>", "Debug targes" },
            e = { "<cmd>RustLsp expandMacro<cr>", "Expand macro" },
            p = { "<cmd>RustLsp rebuildProcMacros<cr>", "Rebuild proc macro" },
            m = { "<cmd>RustLsp parentModule<cr>", "Parent module" },
            u = { "<cmd>RustLsp moveItem up<cr>", "Move item up" },
            d = { "<cmd>RustLsp moveItem down<cr>", "Move item down" },
            H = { "<cmd>RustLsp hover range<cr>", "Hover range" },
            E = { "<cmd>RustLsp explainError<cr>", "Explain error" },
            c = { "<cmd>RustLsp openCargo<cr>", "Open Cargo.toml" },
            t = { "<cmd>RustLsp syntaxTree<cr>", "Syntax tree" },
            j = { "<cmd>RustLsp joinLines", "Join lines" },
            w = { "<cmd>RustLsp reloadWorkspace<cr>", "Reload workspace" },
            D = { "<cmd>RustLsp externalDocs<cr>", "Open docs.rs" },
        },
    }
    which_key.register(mappings, opts)
end

return M
