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
}

M.root_dir = function(fname)
    return util.root_pattern(unpack(M.root_files))(fname) or util.root_pattern ".git"(fname) or util.path.dirname(fname)
end

M.config_pyright = function()
    -- Lsp config
    local pyright_opts = {
        root_dir = M.root_dir,
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

    manager.setup("pyright", pyright_opts)
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
