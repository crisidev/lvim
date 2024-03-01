local M = {}

local icons = require("user.icons").icons

M.lsp_normal_keys = function()
    local ok, wk = pcall(require, "which-key")
    if not ok then
        return
    end

    -- Hover
    lvim.lsp.buffer_mappings.normal_mode["K"] = {
        "<cmd>lua require('user.lsp').show_documentation()<cr>",
        icons.docs .. "Show Documentation",
    }

    wk.register {
        -- Lsp
        ["f"] = {
            ["?"] = icons.debug .. "Add debug",
            name = icons.codelens .. "Lsp actions",
            -- Code actions popup
            A = {
                "<cmd>lua vim.lsp.codelens.run()<cr>",
                icons.codelens .. "Codelens actions",
            },
            a = {
                --     "<cmd>CodeActionMenu<cr>",
                "<cmd>lua require('actions-preview').code_actions()<cr>",
                icons.codelens .. "Code actions",
            },
            -- Goto
            f = {
                "<cmd>lua vim.lsp.buf.definition()<cr>",
                icons.go .. " Goto definition",
            },
            t = {
                "<cmd>lua vim.lsp.buf.type_definition()<cr>",
                icons.go .. " Goto type definition",
            },
            d = {
                "<cmd>lua vim.lsp.buf.declaration()<cR>",
                icons.go .. " Goto declaration",
            },
            r = {
                "<cmd>lua require('user.telescope').lsp_references()<cr>",
                icons.go .. " Goto references",
            },
            i = {
                "<cmd>lua require('user.telescope').lsp_implementations()<cr>",
                icons.go .. " Goto implementations",
            },
            -- Diagnostics
            l = {
                "<cmd>lua vim.diagnostic.open_float({border = 'rounded', focusable = true})<cr>",
                icons.hint .. "Show line diagnostics",
            },
            e = {
                "<cmd>Trouble document_diagnostics<cr>",
                icons.hint .. "Document diagnostics",
            },
            E = {
                "<cmd>Trouble workspace_diagnostics<cr>",
                icons.hint .. "Wordspace diagnostics",
            },
            N = {
                "<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = true, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
                icons.error .. "Next ERROR diagnostic",
            },
            P = {
                "<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = true, source = 'always'}, severity = {min = vim.diagnostic.severity.ERROR}})<cr>",
                icons.error .. "Previous ERROR diagnostic",
            },
            n = {
                "<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = true, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
                icons.warn .. "Next diagnostic",
            },
            p = {
                "<cmd>lua vim.diagnostic.goto_prev({float = {border = 'rounded', focusable = true, source = 'always'}, severity = {min = vim.diagnostic.severity.WARN}})<cr>",
                icons.warn .. "Previous diagnostic",
            },
            s = {
                "<cmd>lua vim.diagnostic.goto_next({float = {border = 'rounded', focusable = true, source = 'always'}, severity = {max = vim.diagnostic.severity.HINT}})<cr>",
                icons.hint .. "Next typo",
            },
            -- Format
            F = {
                "<cmd>lua vim.lsp.buf.format { async = true }<cr>",
                icons.magic .. "Format file",
            },
            -- Rename
            R = {
                "<cmd>lua vim.lsp.buf.rename()<cr>",
                icons.rename .. "Rename symbol",
            },
            x = {
                "<cmd>execute '!open ' . shellescape(expand('<cfile>'), 1)<cr>",
                icons.world .. "Open URL",
            },
            -- Peek
            z = {
                "<cmd>lua require('user.peek').Peek('definition')<cr>",
                icons.find .. " Peek definition",
            },
            Z = {
                name = icons.find .. " Peek",
                d = { "<cmd>lua require('user.peek').Peek('definition')<cr>", "Definition" },
                t = { "<cmd>lua require('user.peek').Peek('typeDefinition')<cr>", "Type Definition" },
                i = { "<cmd>lua require('user.peek').Peek('implementation')<cr>", "Implementation" },
            },
            -- Refactoring
            X = {
                name = icons.palette .. "Refactoring",
                f = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract function" },
                F = {
                    "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
                    "Extract function to file",
                },
                v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract variable" },
                i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline variable" },
                b = { "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", "Extract block" },
                B = {
                    "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>",
                    "Extract block to file",
                },
            },
            -- Trouble
            D = {
                name = icons.error .. "Diagnostics",
                r = { "<cmd>Trouble lsp_references<cr>", "References" },
                f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
                d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
                q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
                l = { "<cmd>Trouble loclist<cr>", "LocationList" },
                w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
            },
            -- Inlay hints
            w = { "<cmd>lua require('user.lsp').toggle_inlay_hints()<cr>", icons.inlay .. "Toggle Inlay" },
            -- Neotest
            T = {
                name = icons.settings .. "Tests",
                f = {
                    "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), env=require('user.ntest').get_env()})<cr>",
                    "File",
                },
                o = { "<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>", "Output" },
                r = { "<cmd>lua require('neotest').run.run({env=require('user.ntest').get_env()})<cr>", "Run" },
                a = { "<cmd>lua require('user.ntest').run_all()<cr>", "Run All" },
                c = { "<cmd>lua require('user.ntest').cancel()<cr>", "Cancel" },
                R = { "<cmd>lua require('user.ntest').run_file_sync()<cr>", "Run Async" },
                s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Toggle summary" },
                n = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", "Jump to next failed" },
                p = {
                    "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>",
                    "Jump to previous failed",
                },
                d = { "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", "Dap Run" },
                l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Last" },
                x = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
                w = { "<cmd>lua require('neotest').watch.watch()<cr>", "Watch" },
                t = { "<cmd>OverseerToggle<cr>", "Toggle tests" },
                T = { "<cmd>OverseerRun<cr>", "Run task" },
                C = { "<cmd>OverseerRunCmd<cr>", "Run task with Cmd" },
            },
        },
    }

    -- Signature
    if lvim.builtin.lsp_signature_help.active then
        vim.keymap.set({ "n" }, "<C-k>", function()
            require("lsp_signature").toggle_float_win()
        end, { silent = true, noremap = true, desc = "Toggle signature" })

        wk.register {
            ["f"] = {
                j = {
                    "<cmd>lua require('lsp_signature').toggle_float_win()<cr>",
                    icons.Function .. " Show signature help",
                },
            },
        }
    else
        vim.keymap.set({ "n" }, "<C-k>", function()
            vim.lsp.buf.signature_help()
        end, { silent = true, noremap = true, desc = "Toggle signature" })

        wk.register {
            ["f"] = {
                j = {
                    "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                    icons.Function .. " Show signature help",
                },
            },
        }
    end

    -- Symbol usage
    if lvim.builtin.symbols_usage.active then
        wk.register {
            ["f"] = {
                W = {
                    name = icons.inlay .. "Symbol usage",
                    t = { "<cmd>lua require('symbol-usage').toggle()<cr>", "Toggle" },
                    r = { "<cmd>lua require('symbol-usage').refresh()<cr>", "Refresh" },
                },
            },
        }
    end

    -- Incremental rename
    if lvim.builtin.noice.active then
        wk.register {
            ["f"] = {
                I = {
                    function()
                        return ":IncRename " .. vim.fn.expand "<cword>"
                    end,
                    icons.rename .. "Rename incremental",
                    expr = true,
                },
            },
        }
    end

    -- Copilot
    if lvim.builtin.copilot.active then
        wk.register {
            ["f"] = {
                C = {
                    name = icons.copilot .. " Copilot",
                    e = { "<cmd>lua require('user.copilot').enable()<cr>", "Enable" },
                    d = { "<cmd>lua require('user.copilot').disable()<cr>", "Disable" },
                    v = { "<cmd>Copilot status<cr>", "Status" },
                    h = { "<cmd>lua require('user.copilot').help()<cr>", "Help" },
                    r = { "<cmd>lua require('user.copilot').restart()<cr>", "Restart" },
                    t = { "<cmd>Copilot toggle<cr>", "Toggle" },
                    P = { "<cmd>Copilot panel<cr>", "Panel" },
                    p = {
                        name = "Panel mode",
                        a = { "<cmd>Copilot panel accept<cr>", "Accept" },
                        n = { "<cmd>Copilot panel jump_next<cr>", "Next" },
                        p = { "<cmd>Copilot panel jump_prev<cr>", "Prev" },
                        r = { "<cmd>Copilot panel refresh<cr>", "Refresh" },
                    },
                    s = { "<cmd>Copilot suggestion<cr>", "Suggestion" },
                    S = { "<cmd>Copilot suggestion toggle_auth_trigger<cr>", "Suggestion auto trigger" },
                },
            },
        }
    end

    -- GPT
    if lvim.builtin.gpt.active then
        wk.register {
            ["f"] = {
                G = {
                    name = icons.gpt .. " ChatGPT",
                    p = { "<cmd>ChatGPT<cr>", "ChatGPT prompt" },
                    a = { "<cmd>ChatGPTActAs<cr>", "Act as" },
                    e = { "<cmd>ChatGPTEditWithInstruction<cr>", "Edit with instruction", mode = { "n", "v" } },
                    c = {
                        name = "Code",
                        d = { "<cmd>ChatGPTRun docstring<cr>", "Docstring", mode = { "n", "v" } },
                        t = { "<cmd>ChatGPTRun add_tests<cr>", "Add Tests", mode = { "n", "v" } },
                        o = { "<cmd>ChatGPTRun optimize_code<cr>", "Optimize Code", mode = { "n", "v" } },
                        f = { "<cmd>ChatGPTRun fix_bugs<cr>", "Fix Bugs", mode = { "n", "v" } },
                        e = { "<cmd>ChatGPTRun explain_code<cr>", "Explain Code", mode = { "n", "v" } },
                        c = { "<cmd>ChatGPTRun complete_code<cr>", "Complete Code", mode = { "n", "v" } },
                        r = {
                            "<cmd>ChatGPTRun code_readability_analysis<cr>",
                            "Code Readability Analysis",
                            mode = { "n", "v" },
                        },
                    },
                    t = {
                        name = "Text",
                        g = { "<cmd>ChatGPTRun grammar_correction<cr>", "Grammar Correction", mode = { "n", "v" } },
                        t = { "<cmd>ChatGPTRun translate<cr>", "Translate", mode = { "n", "v" } },
                        k = { "<cmd>ChatGPTRun keywords<cr>", "Keywords", mode = { "n", "v" } },
                        s = { "<cmd>ChatGPTRun summarize<cr>", "Summarize", mode = { "n", "v" } },
                    },
                },
            },
        }
    end

    -- Tags
    if lvim.builtin.tag_provider == "symbols-outline" then
        wk.register {
            ["f"] = {
                o = { "<cmd>SymbolsOutline<cr>", icons.outline .. " Symbol Outline" },
            },
        }
    elseif lvim.builtin.tag_provider == "vista" then
        wk.register {
            ["f"] = {
                o = { "<cmd>Vista!!<cr>", icons.outline .. " Vista" },
            },
        }
    end
end

M.lsp_visual_keys = function()
    local ok, wk = pcall(require, "which-key")
    if not ok then
        return
    end

    -- Hover
    lvim.lsp.buffer_mappings.visual_mode["K"] = {
        "<cmd>lua require('user.lsp').show_documentation()<cr>",
        icons.docs .. "Show Documentation",
    }

    -- Visual
    wk.register({
        ["f"] = {
            name = icons.codelens .. "Lsp actions",
            -- Refactoring
            X = {
                name = icons.palette .. "Refactoring",
                f = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract function" },
                F = {
                    "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
                    "Extract function to file",
                },
                v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract variable" },
                i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline variable" },
                b = { "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", "Extract block" },
                B = {
                    "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>",
                    "Extract block to file",
                },
            },
            -- Rename
            R = {
                "<cmd>lua vim.lsp.buf.rename()<cr>",
                icons.magic .. "Rename symbol",
            },
            -- Range code actions
            a = {
                "<cmd>lua vim.lsp.buf.range_code_action()<cr>",
                icons.code_lens_action .. "Code actions",
            },
        },
    }, { mode = "v" })

    -- Tags
    if lvim.builtin.tag_provider == "symbols-outline" then
        wk.register {
            ["f"] = {
                o = { "<cmd>SymbolsOutline<cr>", icons.outline .. " Symbol Outline" },
            },
            { mode = "v" },
        }
    elseif lvim.builtin.tag_provider == "vista" then
        wk.register {
            ["f"] = {
                o = { "<cmd>Vista!!<cr>", icons.outline .. " Vista" },
            },
            { mode = "v" },
        }
    end
end

M.config = function()
    M.lsp_normal_keys()
    M.lsp_visual_keys()
end

return M
