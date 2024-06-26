local M = {}

M.config = function()
    local clangd_flags = {
        "--background-index",
        "--fallback-style=google",
        "-j=12",
        "--all-scopes-completion",
        "--pch-storage=memory",
        "--clang-tidy",
        "--log=error",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--enable-config",
        "--offset-encoding=utf-16",
        "--ranking-model=heuristics",
    }

    local provider = "clangd"

    local custom_on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true)
        end
    end

    local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
    if status_ok then
        clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
    end

    local custom_on_init = function(client, bufnr)
        require("lvim.lsp").common_on_init(client, bufnr)
        require("clangd_extensions.config").setup {}
    end

    local opts = {
        cmd = { provider, unpack(clangd_flags) },
        on_attach = custom_on_attach,
        on_init = custom_on_init,
    }

    require("lvim.lsp.manager").setup("clangd", opts)
end

M.cmake_config = function()
    local status_ok, cmake_tools = pcall(require, "cmake-tools")
    if not status_ok then
        return
    end

    cmake_tools.setup {
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_console_size = 10, -- cmake output window height
        cmake_show_console = "always", -- "always", "only_on_error"
        cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
        cmake_dap_open_command = require("dap").repl.open, -- optional
        cmake_variants_message = {
            short = { show = true },
            long = { show = true, max_length = 40 },
        },
    }
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
        B = {
            name = icons.languages.c .. " Build helpers",
            i = { "<cmd>ClangdSymbolInfo<cr>", "Symbol info" },
            s = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch sorce/header" },
            h = { "<cmd>ClangdTypeHierarchy<cr>", "Symbol info" },
            m = { "<cmd>ClangdMemoryUsage<cr>", "Memory usage" },
            a = { "<cmd>ClangdAST<cr>", "Show AST" },
        },
    }
    which_key.register(mappings, opts)
end

return M
