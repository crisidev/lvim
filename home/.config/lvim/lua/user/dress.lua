local M = {}

M.config = function()
    local status_ok, dressing = pcall(require, "dressing")
    if not status_ok then
        return
    end

    dressing.setup {
        input = {
            get_config = function()
                if vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "neo-tree" then
                    return { enabled = false }
                end
            end,
        },
        select = {
            format_item_override = {
                codeaction = function(action_tuple)
                    local title = action_tuple.action.title:gsub("\r\n", "\\r\\n")
                    return string.format("%s", title:gsub("\n", "\\n"))
                end,
            },
        },
        telescope = require("user.telescope").get_theme(),
    }
end

return M
