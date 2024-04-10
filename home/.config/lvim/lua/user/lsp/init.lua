local M = {}

local icons = require("user.icons").icons

M.show_documentation = function()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
    elseif vim.fn.expand "%:t" == "Cargo.toml" then
        require("crates").show_popup()
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
    elseif filetype == "rust" then
        vim.cmd.RustLsp { "hover", "actions" }
    else
        vim.lsp.buf.hover()
    end
end

M.default_diagnostic_config = {
    signs = {
        active = true,
        text = {
            [vim.diagnostic.severity.ERROR] = icons.error,
            [vim.diagnostic.severity.WARN] = icons.warn,
            [vim.diagnostic.severity.INFO] = icons.info,
            [vim.diagnostic.severity.HINT] = icons.hint,
        },
        values = {
            { name = "DiagnosticSignError", text = icons.error },
            { name = "DiagnosticSignWarn", text = icons.warn },
            { name = "DiagnosticSignInfo", text = icons.info },
            { name = "DiagnosticSignHint", text = icons.hint },
        },
    },
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        source = "if_many",
        header = "",
        prefix = "",
        border = {
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
        },
    },
}

M.toggle_inlay_hints = function(buf, value)
    local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
    if type(ih) == "function" then
        ih(buf, value)
    elseif type(ih) == "table" and ih.enable then
        if value == nil then
            value = not ih.is_enabled(buf)
        end
        ih.enable(buf, value)
    end
end

M.config = function()
    -- Log level
    vim.lsp.set_log_level "error"

    -- Disabled server
    -- Remember to run :LvimCacheReset if you change this list.
    vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
        "clangd",
        "gopls",
        "golangci_lint_ls",
        "jdtls",
        "pyright",
        "basedpyright",
        "pylsp",
        "pylyzer",
        "ruff-lsp",
        "rust_analyzer",
        "tsserver",
        "yamlls",
        "grammar_guard",
        "kotlin_language_server",
        "marksman",
        "typos_lsp",
        "dprint",
    })
    lvim.lsp.document_highlight = true
    lvim.lsp.code_lens_refresh = true

    -- Setup diagnostics
    if lvim.builtin.lsp_lines then
        M.default_diagnostic_config.virtual_text = false
    end
    vim.diagnostic.config(M.default_diagnostic_config)

    -- LSP lines
    vim.diagnostic.config { virtual_lines = false, update_in_insert = true }

    local found, noice_util = pcall(require, "noice.util")
    if found and lvim.builtin.noice.active then
        vim.lsp.handlers["textDocument/signatureHelp"] = noice_util.protect(require("noice.lsp").signature)
        vim.lsp.handlers["textDocument/hover"] = noice_util.protect(require("noice.lsp.hover").on_hover)
    else
        local float_config = {
            focusable = true,
            style = "minimal",
            border = {
                { "🭽", "FloatBorder" },
                { "▔", "FloatBorder" },
                { "🭾", "FloatBorder" },
                { "▕", "FloatBorder" },
                { "🭿", "FloatBorder" },
                { "▁", "FloatBorder" },
                { "🭼", "FloatBorder" },
                { "▏", "FloatBorder" },
            },
        }
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_config)
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_config)
    end

    -- Float
    lvim.lsp.document_highlight = true
    lvim.lsp.code_lens_refresh = true

    local default_exe_handler = vim.lsp.handlers["workspace/executeCommand"]
    vim.lsp.handlers["workspace/executeCommand"] = function(err, result, ctx, config)
        -- supress NULL_LS error msg
        if err and vim.startswith(err.message, "NULL_LS") then
            return
        end
        return default_exe_handler(err, result, ctx, config)
    end

    -- Configure null-ls
    require("user.null_ls").config()

    -- Configure Lsp providers
    require("user.lsp.python").config()
    require("user.lsp.go").config()
    require("user.lsp.yaml").config()
    require("user.lsp.toml").config()
    require("user.lsp.markdown").config()
    require("user.lsp.kotlin").config()
    require("user.lsp.rust").config()
    require("user.lsp.typos").config()

    -- Mappings
    require("user.comment").config()
    require("user.lsp.keys").config()
end

return M
