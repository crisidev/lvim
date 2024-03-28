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
            },
            python = {
                analysis = {
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
        single_file_support = true,
        filetypes = { "python" },
    }
    manager.setup("basedpyright", opts)
end

M.config_rufflsp = function()
    local ruff_opts = {
        root_dir = M.root_dir,
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
            e = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick env" },
            E = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show env" },
        },
    }
    which_key.register(mappings, opts)
end

return M
