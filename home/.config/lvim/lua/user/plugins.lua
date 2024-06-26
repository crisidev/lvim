local M = {}

M.config = function()
    lvim.plugins = {
        ------------------------------------------------------------------------------
        -- Themes and visual stuff.
        ------------------------------------------------------------------------------
        {
            "rebelot/kanagawa.nvim",
            config = function()
                require("user.theme").kanagawa()
            end,
        },
        {
            "EdenEast/nightfox.nvim",
            config = function()
                require("user.theme").nightfox()
            end,
        },
        -- Colorizer
        {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("user.colorizer").config()
            end,
            event = "BufReadPre",
        },
        ------------------------------------------------------------------------------
        -- Git and VCS.
        ------------------------------------------------------------------------------
        -- Git blame
        {
            "APZelos/blamer.nvim",
            config = function()
                require("user.blamer").config()
            end,
        },
        -- Github management
        {
            "pwntester/octo.nvim",
            config = function()
                require("user.octo").config()
            end,
            lazy = true,
            dependencies = { "which-key.nvim" },
            cmd = "Octo",
        },
        -- Git linker
        {
            "ruifm/gitlinker.nvim",
            event = "BufRead",
            config = function()
                require("user.gitlinker").config()
            end,
            dependencies = "nvim-lua/plenary.nvim",
        },
        ------------------------------------------------------------------------------
        -- Telescope extensions.
        ------------------------------------------------------------------------------
        -- Telescope zoxide
        {
            "jvgrootveld/telescope-zoxide",
            dependencies = { "nvim-telescope/telescope.nvim" },
            lazy = true,
        },
        -- Telescope file browser
        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = { "nvim-telescope/telescope.nvim" },
            lazy = true,
        },
        -- Telescope live grep
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            dependencies = { "nvim-telescope/telescope.nvim" },
            lazy = true,
        },
        {
            "danielfalk/smart-open.nvim",
            branch = "0.2.x",
            dependencies = {
                "kkharji/sqlite.lua",
                "nvim-telescope/telescope-fzy-native.nvim",
                "nvim-telescope/telescope.nvim",
            },
            lazy = true,
        },
        ------------------------------------------------------------------------------
        -- LSP extensions.
        ------------------------------------------------------------------------------
        -- Lsp signature
        {
            "ray-x/lsp_signature.nvim",
            config = function()
                require("user.lsp.signature").config()
            end,
            ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "rust" },
            enabled = lvim.builtin.lsp_signature_help.active,
        },
        -- Lsp Rust
        {
            "mrcjkb/rustaceanvim",
            version = "^4",
            lazy = false,
        },
        {
            "Canop/nvim-bacon",
            ft = { "rust", "rs" },
            config = function()
                require("bacon").setup {
                    quickfix = {
                        enabled = true,
                        event_trigger = true,
                    },
                }
            end,
            enabled = lvim.builtin.bacon.active,
            lazy = true,
        },
        -- Lsp java
        {
            "mfussenegger/nvim-jdtls",
            ft = "java",
        },
        -- Lsp Typescript
        {
            "jose-elias-alvarez/typescript.nvim",
            ft = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
            lazy = true,
            config = function()
                require("user.lsp.typescript").config()
            end,
        },
        -- Lsp Cland Extensions
        {
            "p00f/clangd_extensions.nvim",
            ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
            config = function()
                require("user.lsp.c").config()
            end,
        },
        {
            "Civitasv/cmake-tools.nvim",
            config = function()
                require("user.lsp.c").cmake_config()
            end,
            ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
        },
        -- Crates
        {
            "Saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                require("crates").setup {
                    null_ls = {
                        enabled = true,
                        name = "crates",
                    },
                    popup = {
                        style = "minimal",
                        border = "rounded",
                    },
                }
            end,
        },
        -- Scala metals
        {
            "scalameta/nvim-metals",
            dependencies = { "nvim-lua/plenary.nvim" },
            ft = { "scala", "sbt" },
            enabled = lvim.builtin.metals.active,
        },
        -- Go
        {
            "olexsmir/gopher.nvim",
            config = function()
                require("gopher").setup {
                    commands = {
                        go = "go",
                        gomodifytags = "gomodifytags",
                        gotests = "gotests",
                        impl = "impl",
                        iferr = "iferr",
                    },
                }
            end,
            ft = { "go", "gomod" },
        },
        -- Node
        {
            "vuki656/package-info.nvim",
            config = function()
                require("package-info").setup()
            end,
            lazy = true,
            event = { "BufReadPre", "BufNew" },
        },
        -- Refactoring
        {
            "icholy/lsplinks.nvim",
            init = function()
                require("lsplinks").setup()
            end,
        },
        {
            "ThePrimeagen/refactoring.nvim",
            ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "rust", "kotlin" },
            lazy = true,
            config = function()
                require("user.refactoring").config()
            end,
        },
        {
            "cshuaimin/ssr.nvim",
            config = function()
                require("ssr").setup {
                    min_width = 50,
                    min_height = 5,
                    keymaps = {
                        close = "q",
                        next_match = "n",
                        prev_match = "N",
                        replace_all = "<leader><cr>",
                    },
                }
            end,
            lazy = true,
            event = { "BufReadPost", "BufNew" },
        },
        -- Symbols
        {
            "Wansmer/symbol-usage.nvim",
            event = "LspAttach",
            enabled = lvim.builtin.symbols_usage.active,
            config = function()
                require("user.symbol_use").config()
            end,
        },
        {
            "simrat39/symbols-outline.nvim",
            config = function()
                require("user.outline").config()
            end,
            event = "BufReadPost",
            enabled = lvim.builtin.tag_provider == "symbols-outline",
        },
        -- Preview code actions
        {
            "aznhe21/actions-preview.nvim",
            config = function()
                require("actions-preview").setup {
                    telescope = {
                        sorting_strategy = "ascending",
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.8,
                            height = 0.9,
                            prompt_position = "top",
                            preview_cutoff = 20,
                            preview_height = function(_, _, max_lines)
                                return max_lines - 20
                            end,
                        },
                    },
                }
            end,
        },
        {
            "abzcoding/lsp_lines.nvim",
            lazy = true,
            config = function()
                require("lsp_lines").setup()
            end,
            enabled = lvim.builtin.lsp_lines,
        },
        ------------------------------------------------------------------------------
        -- A/I
        ------------------------------------------------------------------------------
        -- Copilot
        {
            "zbirenbaum/copilot.lua",
            event = "VimEnter",
            enabled = lvim.builtin.copilot.active,
        },
        {
            "zbirenbaum/copilot-cmp",
            dependencies = { "copilot.lua", "nvim-cmp" },
            config = function()
                require("copilot_cmp").setup {
                    method = "getCompletionsCycling",
                }
            end,
            enabled = lvim.builtin.copilot.active,
        },
        -- Gpt
        {
            "jackMort/ChatGPT.nvim",
            event = "VeryLazy",
            config = function()
                if vim.fn.filereadable(vim.fn.expand "~/.config/lvim/.gpt") == 1 then
                    local ok, gpt
                    pcall(require, "chatgpt")
                    if ok then
                        gpt.setup {
                            api_key_cmd = "cat ~/.config/lvim/.gpt",
                        }
                    end
                end
            end,
            dependencies = {
                "MunifTanjim/nui.nvim",
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
            },
            enabled = lvim.builtin.gpt.active,
        },
        ------------------------------------------------------------------------------
        -- Cmp all the things.
        ------------------------------------------------------------------------------
        { "hrsh7th/cmp-emoji" },
        { "hrsh7th/cmp-nvim-lsp" },
        {
            "petertriho/cmp-git",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("cmp_git").setup()
            end,
        },
        {
            "hrsh7th/cmp-nvim-lsp-signature-help",
            enabled = lvim.builtin.lsp_signature_help.active,
        },
        {
            "vrslev/cmp-pypi",
            dependencies = { "nvim-lua/plenary.nvim" },
            ft = "toml",
        },
        ------------------------------------------------------------------------------
        -- Markdown support
        ------------------------------------------------------------------------------
        -- Markdown preview
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && yarn install",
            init = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        },
        -- Glow markdown preview
        {
            "ellisonleao/glow.nvim",
            ft = { "markdown" },
        },
        -- Markdown TOC
        {
            "mzlogin/vim-markdown-toc",
            ft = "markdown",
        },
        {
            "jghauser/follow-md-links.nvim",
            ft = { "markdown" },
        },
        ------------------------------------------------------------------------------
        -- Spelling and grammar
        ------------------------------------------------------------------------------
        -- Spelling
        {
            "lewis6991/spellsitter.nvim",
            config = function()
                require("spellsitter").setup {
                    hl = "SpellBad",
                    captures = { "comment" },
                }
            end,
            ft = { "markdown", "text", "rst" },
        },
        -- Grammarous
        {
            "rhysd/vim-grammarous",
            cmd = "GrammarousCheck",
            enabled = lvim.builtin.grammarous.active,
        },
        -- Grammar guard
        {
            "brymer-meneses/grammar-guard.nvim",
            ft = { "latex", "tex", "bib", "markdown", "rst", "text" },
            dependencies = { "neovim/nvim-lspconfig" },
        },
        ------------------------------------------------------------------------------
        -- Session and position
        ------------------------------------------------------------------------------
        -- Pick up where you left
        {
            "vladdoster/remember.nvim",
            config = function()
                require("remember").setup {}
            end,
        },
        -- Session manager
        {
            "olimorris/persisted.nvim",
            lazy = true,
            config = function()
                require("user.persisted").config()
            end,
        },
        ------------------------------------------------------------------------------
        -- Zen mode
        ------------------------------------------------------------------------------
        {
            "folke/zen-mode.nvim",
            cmd = "ZenMode",
            lazy = true,
            config = function()
                require("user.zen").config()
            end,
        },
        {
            "folke/twilight.nvim",
            config = function()
                require("user.twilight").config()
            end,
            lazy = true,
            cmd = "Twilight",
            enabled = lvim.builtin.twilight.enable,
        },
        ------------------------------------------------------------------------------
        -- Search and replace
        ------------------------------------------------------------------------------
        -- Hlslens
        {
            "kevinhwang91/nvim-hlslens",
            config = function()
                require("user.hlslens").config()
            end,
            event = "BufReadPost",
        },
        -- Spectre
        {
            "nvim-pack/nvim-spectre",
            event = "BufRead",
            lazy = true,
            config = function()
                require("user.spectre").config()
            end,
        },
        ------------------------------------------------------------------------------
        -- Movements
        ------------------------------------------------------------------------------
        -- Zoxide
        { "nanotee/zoxide.vim" },
        -- Preview jumps
        {
            "nacro90/numb.nvim",
            event = "BufRead",
            config = function()
                require("numb").setup()
            end,
        },
        -- Neotree
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            dependencies = { "MunifTanjim/nui.nvim" },
            config = function()
                require("user.neotree").config()
            end,
            enabled = lvim.builtin.tree_provider == "neo-tree",
        },
        -- Treesitter textobject
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            lazy = true,
            event = "BufReadPre",
            dependencies = "nvim-treesitter",
            enabled = lvim.builtin.treesitter_textobjects.active,
        },
        ------------------------------------------------------------------------------
        -- Debug
        ------------------------------------------------------------------------------
        {
            "leoluz/nvim-dap-go",
            config = function()
                require("dap-go").setup()
            end,
            lazy = true,
            ft = { "go", "gomod" },
        },
        {
            "mfussenegger/nvim-dap-python",
            config = function()
                local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
                require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
                require("dap-python").test_runner = "pytest"
            end,
            lazy = true,
            ft = "python",
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            config = function()
                require("nvim-dap-virtual-text").setup()
            end,
            lazy = true,
        },
        ------------------------------------------------------------------------------
        -- Noice
        ------------------------------------------------------------------------------
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            config = function()
                require("user.noice").config()
            end,
            -- version = '1.5.2',
            dependencies = {
                "rcarriga/nvim-notify",
                "MunifTanjim/nui.nvim",
                "smjonas/inc-rename.nvim",
            },
            enabled = lvim.builtin.noice.active,
        },
        ------------------------------------------------------------------------------
        -- Miscellaneous
        ------------------------------------------------------------------------------
        -- Screenshots
        {
            "segeljakt/vim-silicon",
            config = function()
                require("user.silicon").config()
            end,
            event = "VeryLazy",
            cmd = "Silicon",
        },
        -- TODO comments
        {
            "folke/todo-comments.nvim",
            dependencies = "nvim-lua/plenary.nvim",
            config = function()
                require("user.todo_comments").config()
            end,
            event = "BufRead",
        },
        -- Qbf
        {
            "kevinhwang91/nvim-bqf",
            config = function()
                require("user.bqf").config()
            end,
            event = "WinEnter",
        },
        -- Trouble
        {
            "folke/trouble.nvim",
            config = function()
                require("user.trouble").config()
            end,
            cmd = "Trouble",
            event = "VeryLazy",
        },
        -- Dressing
        {
            "stevearc/dressing.nvim",
            config = function()
                require("user.dress").config()
            end,
            lazy = true,
            event = "BufWinEnter",
        },
        -- i3 syntax
        { "mboughaba/i3config.vim" },
        -- Visual multi
        {
            "mg979/vim-visual-multi",
            init = function()
                vim.cmd [[
                    let g:VM_maps = {}
                    let g:VM_maps['Find Under'] = '<C-l>'
                ]]
            end,
            branch = "master",
        },
        -- Incline
        {
            "b0o/incline.nvim",
            config = function()
                require("user.incline").config()
            end,
            enabled = lvim.builtin.breadcrumbs.provider == "incline",
        },
        {
            "Bekaboo/dropbar.nvim",
            enabled = lvim.builtin.breadcrumbs.provider == "dropbar",
        },
        -- Cleanup whitespaces
        {
            "lewis6991/spaceless.nvim",
            config = function()
                require("spaceless").setup()
            end,
        },
        -- Better hl
        {
            "m-demare/hlargs.nvim",
            config = function()
                require("hlargs").setup {
                    excluded_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
                }
            end,
            lazy = true,
            event = "VeryLazy",
            dependencies = { "nvim-treesitter/nvim-treesitter" },
        },
        -- Testing
        {
            "stevearc/overseer.nvim",
            config = function()
                require("user.overseer").config()
            end,
        },
        {
            "nvim-neotest/neotest",
            config = function()
                require("user.ntest").config()
            end,
            dependencies = {
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-treesitter/nvim-treesitter",
            },
        },
        { "nvim-neotest/neotest-plenary" },
        { "nvim-neotest/neotest-go" },
        { "nvim-neotest/neotest-python" },
        { "rouge8/neotest-rust" },
        { "nvim-neotest/nvim-nio" },
        -- Hop
        {
            "phaazon/hop.nvim",
            event = "VeryLazy",
            cmd = { "HopChar1CurrentLineAC", "HopChar1CurrentLineBC", "HopChar2MW", "HopWordMW" },
            config = function()
                require("user.hop").config()
            end,
            enabled = lvim.builtin.motion_provider == "hop",
        },
        -- Flash
        {
            "folke/flash.nvim",
            event = "VeryLazy",
            keys = require("user.flash").keys,
            enabled = lvim.builtin.motion_provider == "flash",
        },
        -- Highligh logs
        {
            "mtdl9/vim-log-highlighting",
            ft = { "text", "log" },
            lazy = true,
        },
        -- Powerful tab
        {
            "abecodes/tabout.nvim",
            config = function()
                require("user.tabout").config()
            end,
        },
        -- Debug print
        {
            "andrewferrier/debugprint.nvim",
            config = function()
                require("user.debugprint").config()
            end,
        },
        -- Status column
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                require("user.statuscol").config()
            end,
            enabled = lvim.builtin.statuscol.active,
        },
        -- Hearthly files
        { "earthly/earthly.vim" },
        -- Startup time
        {
            "dstein64/vim-startuptime",
            enabled = lvim.builtin.startuptime.active,
        },
        -- Tags
        {
            "liuchengxu/vista.vim",
            init = function()
                require("user.vista").config()
            end,
            event = "BufReadPost",
            enabled = lvim.builtin.tag_provider == "vista",
        },
        -- Mind
        {
            "Selyss/mind.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                require("user.mind").config()
            end,
            event = "VeryLazy",
            enabled = lvim.builtin.mind.active,
        },
        -- File icons
        {
            "abzcoding/nvim-mini-file-icons",
            config = function()
                require("nvim-web-devicons").setup()
            end,
            enabled = not lvim.use_icons,
        },
        -- Code coverage
        {
            "andythigpen/nvim-coverage",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                require("coverage").setup()
            end,
        },
        { "Glench/Vim-Jinja2-Syntax" },
        {
            "wookayin/semshi",
            ft = "python",
            build = ":UpdateRemotePlugins",
            init = function()
                require("user.semshi").config()
            end,
        },
    }
end

return M
