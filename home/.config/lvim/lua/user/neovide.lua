local M = {}

M.scale = function(amount)
    local temp = vim.g.neovide_scale_factor + amount

    if temp < 1.0 then
        return
    end

    vim.g.neovide_scale_factor = temp
end

M.config = function()
    if vim.g.neovide then
        vim.opt.guifont = "MonoLisa Nerd Font:h12"
        vim.opt.linespace = 0
        vim.g.neovide_scale_factor = 1.0
        vim.g.neovide_padding_top = 0
        vim.g.neovide_padding_bottom = 0
        vim.g.neovide_padding_right = 0
        vim.g.neovide_padding_left = 0
        vim.g.neovide_floating_blur_amount_x = 2.0
        vim.g.neovide_floating_blur_amount_y = 2.0
        vim.g.neovide_transparency = 1.0
        vim.g.neovide_scroll_animation_length = 0.0
        vim.g.neovide_hide_mouse_when_typing = false
        vim.g.neovide_underline_automatic_scaling = false
        vim.g.neovide_refresh_rate = 60
        vim.g.neovide_refresh_rate_idle = 5
        vim.g.neovide_no_idle = false
        vim.g.neovide_confirm_quit = true
        vim.g.neovide_fullscreen = false
        vim.g.neovide_remember_window_size = false
        vim.g.neovide_profiler = false
        vim.g.neovide_touch_deadzone = 6.0
        vim.g.neovide_touch_drag_timeout = 0.0
        vim.g.neovide_cursor_animation_length = 0.0
        vim.g.neovide_cursor_trail_size = 0.0
        vim.g.neovide_cursor_antialiasing = true
        vim.g.neovide_cursor_animate_in_insert_mode = false
        vim.g.neovide_cursor_animate_command_line = false
        vim.g.neovide_cursor_unfocused_outline_width = 0.0
        vim.g.neovide_cursor_vfx_mode = ""
        vim.g.neovide_input_use_logo = 1

        -- Remapping
        vim.api.nvim_set_keymap(
            "n",
            "<D-=>",
            "<cmd>lua require('user.neovide').scale(0.1)<cr>",
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            "n",
            "<D-->",
            "<cmd>lua require('user.neovide').scale(-0.1)<cr>",
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("", "<D-/>", "+p<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("!", "<D-/>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("t", "<D-/>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("v", "<D-/>", "<C-R>+", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("v", "<D-c>", "+yi", { noremap = true, silent = true })
    end
end

return M
