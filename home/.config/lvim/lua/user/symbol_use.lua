local M = {}

M.config = function()
    local status_ok, sym = pcall(require, "symbol-usage")
    if not status_ok then
        return
    end
    local icons = require("user.icons").symbol_usage

    local text_format = function(symbol)
        local res = {}
        local ins = table.insert

        local round_start = { icons.circle_left, "SymbolUsageRounding" }
        local round_end = { icons.circle_right, "SymbolUsageRounding" }

        if symbol.references and symbol.references > 0 then
            local usage = symbol.references <= 1 and "usage" or "usages"
            local num = symbol.references == 0 and "no" or symbol.references
            ins(res, round_start)
            ins(res, { icons.ref, "SymbolUsageRef" })
            ins(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
            ins(res, round_end)
        end

        if symbol.definition and symbol.definition > 0 then
            if #res > 0 then
                table.insert(res, { " ", "NonText" })
            end
            ins(res, round_start)
            ins(res, { icons.def, "SymbolUsageDef" })
            ins(res, { symbol.definition .. " defs", "SymbolUsageContent" })
            ins(res, round_end)
        end

        if symbol.implementation and symbol.implementation > 0 then
            if #res > 0 then
                table.insert(res, { " ", "NonText" })
            end
            ins(res, round_start)
            ins(res, { icons.impl, "SymbolUsageImpl" })
            ins(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
            ins(res, round_end)
        end

        return res
    end
    sym.setup {
        vt_position = "end_of_line",
        text_format = text_format,
        references = { enabled = true, include_declaration = false },
        definition = { enabled = true },
        implementation = { enabled = true },
    }
end

return M
