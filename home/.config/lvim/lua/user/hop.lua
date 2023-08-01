local M = {}

M.config = function()
    require("hop").setup()
    M.keys()
end

M.keys = function()
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "s", ":HopChar2MW<cr>", opts)
    vim.api.nvim_set_keymap("n", "S", ":HopWordMW<cr>", opts)
    vim.api.nvim_set_keymap(
        "n",
        "l",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
        {}
    )
    vim.api.nvim_set_keymap(
        "n",
        "L",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
        {}
    )
    vim.api.nvim_set_keymap(
        "o",
        "l",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
        {}
    )
    vim.api.nvim_set_keymap(
        "o",
        "L",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
        {}
    )
    vim.api.nvim_set_keymap(
        "",
        "t",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
        {}
    )
    vim.api.nvim_set_keymap(
        "",
        "T",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
        {}
    )
end

return M
