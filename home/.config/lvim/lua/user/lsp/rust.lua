local M = {}

M.config = function()
    local opts = {
        tools = {
            executor = require "rustaceanvim.executors.termopen", -- can be quickfix or termopen
            reload_workspace_from_cargo_toml = true,
            inlay_hints = {
                auto = not lvim.builtin.automatic_inlay_hints.active,
                only_current_line = true,
                show_parameter_hints = true,
                parameter_hints_prefix = "in: ",
                other_hints_prefix = " out: ",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 7,
                highlight = "SpecialComment",
            },
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
            on_attach = function(client, bufnr)
                require("lvim.lsp").common_on_attach(client, bufnr)
            end,
            on_init = require("lvim.lsp").common_on_init,
            capabilities = require("lvim.lsp").common_capabilities(),
            default_settings = {
                ["rust-analyzer"] = {
                    inlayHints = {
                        locationLinks = false,
                    },
                    lens = {
                        enable = true,
                    },
                    checkOnSave = {
                        enable = true,
                        command = "clippy",
                    },
                    diagnostics = {
                        experimental = true,
                    },
                    cargo = {
                        features = "all",
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
        B = {
            name = icons.languages.rust .. " Build helpers",
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
