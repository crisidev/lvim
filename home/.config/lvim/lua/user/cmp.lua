local M = {}

M.kind = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Collapsed = " ",
    Color = " ",
    Constant = "",
    Constructor = " ",
    Control = " ",
    Copilot = " ",
    Default = " ",
    Enum = "ℰ",
    EnumMember = " ",
    Event = " ",
    Field = "󰜢",
    File = "󰈚",
    Folder = " ",
    Function = " ",
    Implementation = "",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Macro = " ",
    Method = "ƒ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Parameter = "",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    spell = "󰓆 ",
    StaticMethod = "",
    String = "󰅳 ", -- " ","𝓐 " ," " ,"󰅳 "
    Struct = "󰙅",
    TabNine = "󰏚 ",
    Text = " ",
    TypeAlias = "",
    TypeParameter = " ",
    Undefined = "",
    Unit = "󰑭",
    Value = " ",
    Variable = "󰀫 ",
}

M.config = function()
    local cmp = require "cmp"
    table.insert(lvim.builtin.cmp.sources, { name = "git" })
    table.insert(lvim.builtin.cmp.sources, { name = "emoji" })
    table.insert(lvim.builtin.cmp.sources, { name = "dictionary" })
    table.insert(lvim.builtin.cmp.sources, { name = "nvim_lsp_signature_help" })
    table.insert(lvim.builtin.cmp.sources, { name = "pypi", keyword_length = 4 })

    lvim.builtin.cmp.experimental = {
        ghost_text = true,
    }
    local cmp_border = {
        { "╭", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╮", "CmpBorder" },
        { "│", "CmpBorder" },
        { "╯", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╰", "CmpBorder" },
        { "│", "CmpBorder" },
    }
    local cmp_sources = {
        ["vim-dadbod-completion"] = "(DadBod)",
        buffer = "(Buffer)",
        crates = "(Crates)",
        latex_symbols = "(LaTeX)",
        nvim_lua = "(NvLua)",
        copilot = "(Copilot)",
        dictionary = "(Dict)",
    }
    -- Borderless cmp
    vim.opt.pumblend = 4
    lvim.builtin.cmp.formatting.fields = { "abbr", "kind", "menu" }
    lvim.builtin.cmp.window = {
        completion = {
            border = cmp_border,
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
            border = cmp_border,
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        },
    }
    lvim.builtin.cmp.formatting.format = function(entry, vim_item)
        if entry.source.name == "cmdline_history" or entry.source.name == "cmdline" then
            vim_item.kind = "⌘"
            vim_item.menu = ""
            return vim_item
        end
        vim_item.kind =
            string.format("%s %s", M.kind[vim_item.kind] or " ", cmp_sources[entry.source.name] or vim_item.kind)

        return vim_item
    end
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline {
            ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        },
        sources = {
            { name = "cmdline" },
            { name = "path" },
        },
        window = {
            completion = {
                border = cmp_border,
                winhighlight = "Search:None",
            },
        },
    })
    for _, cmd_type in ipairs { "/", "?" } do
        cmp.setup.cmdline(cmd_type, {
            mapping = cmp.mapping.preset.cmdline {},
            sources = {
                { name = "buffer" },
                { name = "path" },
            },
            window = {
                completion = {
                    border = cmp_border,
                    winhighlight = "Search:None",
                },
            },
        })
    end
end

return M
