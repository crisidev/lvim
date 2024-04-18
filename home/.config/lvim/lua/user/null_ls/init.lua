local M = {}

M.config = function()
    local status_ok, nls = pcall(require, "null-ls")
    if not status_ok then
        return
    end
    local custom_go_actions = require "user.null_ls.go"

    local sources = {
        -- Formatting
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofumpt,
        nls.builtins.formatting.clang_format.with {
            filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
        },
        nls.builtins.formatting.cmake_format,
        nls.builtins.formatting.scalafmt,
        nls.builtins.formatting.terraform_fmt,
        nls.builtins.formatting.shfmt.with {
            extra_args = { "-i", "4", "-ci" },
        },
        nls.builtins.formatting.isort.with {
            extra_args = { "--profile=black" },
        },
        nls.builtins.formatting.black.with {
            extra_args = { "--fast", "--line-length=120" },
        },

        -- Diagnostics
        nls.builtins.diagnostics.alex,
        nls.builtins.diagnostics.ansiblelint.with {
            condition = function(utils)
                return (utils.root_has_file "roles" and utils.root_has_file "inventory")
                    or utils.root_has_file "ansible"
            end,
        },
        nls.builtins.diagnostics.checkmake,
        nls.builtins.diagnostics.cmake_lint,
        nls.builtins.diagnostics.hadolint,
        nls.builtins.diagnostics.selene,
        nls.builtins.diagnostics.vint,
        nls.builtins.diagnostics.markdownlint.with {
            filetypes = { "markdown" },
            extra_args = { "-r", "~MD013" },
        },
        nls.builtins.diagnostics.zsh,
        nls.builtins.diagnostics.terraform_validate,

        -- Code actions
        nls.builtins.code_actions.refactoring.with {
            filetypes = { "typescript", "javascript", "c", "cpp", "go", "python" },
        },
        nls.builtins.code_actions.gitrebase,
        nls.builtins.code_actions.gitsigns,
        nls.builtins.code_actions.impl,
        custom_go_actions.gomodifytags,
        custom_go_actions.gostructhelper,

        -- Hover
        nls.builtins.hover.dictionary,
        -- nls.builtins.hover.printenv,
    }
    local ts_found, typescript_code_actions = pcall(require, "typescript.extensions.null-ls.code-actions")
    if ts_found then
        table.insert(sources, typescript_code_actions)
    end

    -- you can either config null-ls itself
    nls.setup {
        on_attach = require("lvim.lsp").common_on_attach,
        debounce = 150,
        save_after_format = false,
        sources = sources,
    }
end

return M
