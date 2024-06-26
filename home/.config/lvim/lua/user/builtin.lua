local M = {}

M.config = function()
    -- Theme
    lvim.colorscheme = "tokyonight"
    require("user.theme").tokyonight()
    lvim.builtin.theme.name = "tokyonight"

    -- Builtins
    lvim.leader = ","
    lvim.format_on_save = false
    lvim.line_wrap_cursor_movement = false
    lvim.reload_config_on_save = false
    lvim.termguicolors = true
    lvim.transparent_window = false
    lvim.reload_config_on_save = true
    lvim.debug = false

    -- Telescope
    lvim.builtin.telescope.active = true
    -- Tree support
    lvim.builtin.tree_provider = "neo-tree"
    lvim.builtin.nvimtree.active = false
    -- Project
    lvim.builtin.project.active = true
    lvim.builtin.project.detection_methods = { "lsp", "pattern" }
    -- Debugging
    lvim.builtin.dap.active = true
    -- Noice
    lvim.builtin.noice = { active = true }
    -- Grammarous
    lvim.builtin.grammarous = { active = false }
    -- Twilight
    lvim.builtin.twilight = { enable = true }
    -- Copilot
    lvim.builtin.copilot = { active = false }
    -- GPT
    lvim.builtin.gpt = { active = true }
    -- LSP Signature help
    lvim.builtin.lsp_signature_help = { active = true }
    -- Lir
    lvim.builtin.lir.active = false
    -- Breadcrumbs
    lvim.builtin.breadcrumbs.provider = "incline"
    if lvim.builtin.breadcrumbs.provider == "none" then
        lvim.builtin.breadcrumbs.active = true
    else
        lvim.builtin.breadcrumbs.active = false
    end
    -- Tags
    lvim.builtin.tag_provider = "symbols-outline"
    -- Illuminate
    lvim.builtin.illuminate.active = true
    -- Indent lines
    lvim.builtin.indentlines.active = false
    -- Global status line
    lvim.builtin.global_statusline = true
    -- Cmpline
    lvim.builtin.cmp.cmdline.enable = true
    -- Big file management
    lvim.builtin.bigfile.active = true
    -- Scala
    lvim.builtin.metals = { active = false }
    -- Hop / Flash
    lvim.builtin.motion_provider = "none"
    -- Enable symbol usage
    lvim.builtin.symbols_usage = { active = true }
    -- Enable bacon for Rust
    lvim.builtin.bacon = { active = false }
    -- Enable the status column
    lvim.builtin.statuscol = { active = false }
    -- Enable lsp lines
    lvim.builtin.lsp_lines = { active = true }
    -- Enable startup time
    lvim.builtin.startuptime = { active = false }

    -- Icons
    lvim.use_icons = true
    require("user.icons").use_my_icons()

    -- Mason
    lvim.builtin.mason.ui.icons = require("user.icons").mason
    lvim.builtin.treesitter_textobjects = { active = false }

    -- Dashboard
    lvim.builtin.alpha.active = true
    lvim.builtin.alpha.mode = "custom"
    lvim.builtin.alpha["custom"] = { config = require("user.dashboard").config() }

    -- Git signs
    lvim.builtin.gitsigns.opts._threaded_diff = true
    lvim.builtin.gitsigns.opts._extmark_signs = true
    lvim.builtin.gitsigns.opts.attach_to_untracked = false
    lvim.builtin.gitsigns.opts.current_line_blame_formatter = " <author>, <author_time> · <summary>"
    lvim.builtin.gitsigns.opts.yadm = nil

    -- Mind
    lvim.builtin.mind = { active = true, root_path = "~/.mind" }
    -- Log level
    lvim.log.level = "warn"
end

M.smart_quit = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
    vim.cmd "Neotree close"
    if modified then
        vim.ui.input({
            prompt = "You have unsaved changes. Quit anyway? (y/n) ",
        }, function(input)
            if input == "y" then
                vim.cmd "q!"
            end
        end)
    else
        vim.cmd "q!"
    end
end

return M
