local util = require "lspconfig.util"
local manager = require "lvim.lsp.manager"
local which_key = require "which-key"
local icons = require "user.icons"

local M = {}

M.root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "manage.py",
    "pyrightconfig.json",
    "poetry.lock",
}

M.root_dir = function(fname)
    return util.root_pattern(unpack(M.root_files))(fname) or util.root_pattern ".git"(fname) or util.path.dirname(fname)
end

M.config_pyright = function()
    local cmd = { "pyright-langserver", "--stdio" }
    local match = vim.fn.glob(vim.fn.getcwd() .. "/poetry.lock")
    if match ~= "" then
        cmd = { "poetry", "run", "pyright-langserver", "--stdio" }
    end
    local opts = {
        cmd = cmd,
        root_dir = M.root_dir,
        on_attach = require("lvim.lsp").common_on_attach,
        on_init = require("lvim.lsp").common_on_init,
        capabilities = require("lvim.lsp").common_capabilities(),
        settings = {
            pyright = {
                disableLanguageServices = false,
                disableOrganizeImports = false,
                disableTaggedHints = false,
            },
            python = {
                analysis = {
                    autoImportCompletions = true,
                    typeCheckingMode = "strict",
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                },
            },
        },
        single_file_support = true,
        filetypes = { "python" },
    }

    manager.setup("pyright", opts)
end

M.config_pylsp = function()
    local cmd = { "pylsp" }
    local match = vim.fn.glob(vim.fn.getcwd() .. "/poetry.lock")
    if match ~= "" then
        cmd = { "poetry", "run", "pylsp" }
    end
    local opts = {
        cmd = cmd,
        root_dir = M.root_dir,
        on_attach = require("lvim.lsp").common_on_attach,
        on_init = require("lvim.lsp").common_on_init,
        capabilities = require("lvim.lsp").common_capabilities(),
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = { "W391" },
                        maxLineLength = 120,
                    },
                    jedi_completion = {
                        enabled = false,
                    },
                },
            },
        },
        single_file_support = true,
        filetypes = { "python" },
    }

    manager.setup("pylsp", opts)
end

M.config_pylyzer = function()
    local cmd = { "pylyzer", "--server" }
    local match = vim.fn.glob(vim.fn.getcwd() .. "/poetry.lock")
    if match ~= "" then
        cmd = { "poetry", "run", "pylyzer", "--server" }
    end
    local opts = {
        cmd = cmd,
        root_dir = M.root_dir,
        on_attach = function(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end
            require("lvim.lsp").common_on_attach(client, bufnr)
        end,
        on_init = require("lvim.lsp").common_on_init,
        capabilities = require("lvim.lsp").common_capabilities(),
        settings = {
            python = {
                checkOnType = false,
                diagnostics = false,
                inlayHints = true,
                smartCompletion = true,
            },
        },
        single_file_support = true,
        filetypes = { "python" },
    }
    manager.setup("pylyzer", opts)
end

M.config_basedpyright = function()
    local cmd = { "basedpyright-langserver", "--stdio" }
    local match = vim.fn.glob(vim.fn.getcwd() .. "/poetry.lock")
    if match ~= "" then
        cmd = { "poetry", "run", "basedpyright-langserver", "--stdio" }
    end
    local opts = {
        cmd = cmd,
        root_dir = M.root_dir,
        on_attach = require("lvim.lsp").common_on_attach,
        on_init = require("lvim.lsp").common_on_init,
        capabilities = require("lvim.lsp").common_capabilities(),
        settings = {
            basedpyright = {
                disableLanguageServices = false,
                disableOrganizeImports = false,
                disableTaggedHints = false,
                openFilesOnly = false,
                useLibraryCodeForTypes = true,
                analysis = {
                    autoImportCompletions = true,
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    typeCheckingMode = "strict",
                    useLibraryCodeForTypes = true,
                },
            },
        },
        single_file_support = true,
        filetypes = { "python" },
    }
    manager.setup("basedpyright", opts)
end

M.config_rufflsp = function()
    local ruff_opts = {
        root_dir = M.root_dir,
        on_attach = function(client, bufnr)
            if client.name == "ruff_lsp" then
                -- client.server_capabilities.hoverProvider = false
                client.server_capabilities.documentFormattingProvider = false
            end
            require("lvim.lsp").common_on_attach(client, bufnr)
        end,
        on_init = require("lvim.lsp").common_on_init,
        capabilities = require("lvim.lsp").common_capabilities(),
        single_file_support = true,
        filetypes = { "python" },
    }

    manager.setup("ruff_lsp", ruff_opts)
end

M.build_tools = function()
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
            name = icons.languages.python .. " Build helpers",
            c = { "<cmd>lua require('dap-python').test_class()<cr>", "Test class" },
            m = { "<cmd>lua require('dap-python').test_method()<cr>", "Test method" },
            s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug selection" },
            i = { "<cmd>PyrightOrganizeImports<cr>", "Organize imports" },
        },
    }
    which_key.register(mappings, opts)
end

M.config = function()
    M.config_basedpyright()
    -- M.config_pylyzer()
    -- M.config_pyright()
    -- M.config_pylsp()
    -- M.config_rufflsp()
end

return M
