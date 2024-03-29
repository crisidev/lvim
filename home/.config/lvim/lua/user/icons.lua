local M = {}

M.icons = {
    vim = " ",
    error = " ",
    warn = " ",
    info = "󰗖 ",
    hint = " ",
    debug = " ",
    trace = "✎",
    code_action = "",
    code_lens_action = "󰄄 ",
    test = " ",
    docs = " ",
    clock = " ",
    calendar = " ",
    buffer = "󱡗 ",
    layers = "",
    settings = " ",
    ls_active = "󰕮 ",
    ls_inactive = "",
    question = " ",
    added = "  ",
    modified = " ",
    removed = " ",
    screen = "冷",
    config = " ",
    git = "",
    magic = " ",
    exit = " ",
    exit2 = " ",
    session = "󰔚 ",
    project = "⚝ ",
    stuka = " ",
    text = "󰊄",
    files = " ",
    zoxide = "",
    repo = "",
    term = " ",
    palette = " ",
    buffers = "󰨝 ",
    telescope = "",
    dashboard = "󰕮 ",
    boat = " ",
    unmute = "",
    mute = "",
    quit = "󰗼",
    replace = "",
    find = "",
    comment = "",
    ok = "",
    no = "",
    moon = "",
    go = "",
    resume = " ",
    codelens = "󰄄 ",
    folder = "",
    package = "",
    spelling = " ",
    copilot = "",
    gpt = "",
    attention = "",
    Function = "",
    power = "󰚥",
    zen = "",
    music = "",
    nuclear = "☢",
    grammar = "暈",
    treesitter = "",
    lock = "",
    presence_on = "󰅠 ",
    presence_off = " ",
    caret = "-",
    flash = " ",
    world = " ",
    label = " ",
    person = "",
    expanded = "",
    collapsed = "",
    circular = "",
    circle_left = "",
    circle_right = "",
    neotest = "ﭧ",
    rename = " ",
    amazon = " ",
    inlay = " ",
    pinned = " ",
    mind = " ",
    mind_tasks = "󱗽",
    mind_backlog = " ",
    mind_on_going = " ",
    mind_done = " ",
    mind_cancelled = " ",
    mind_notes = " ",
    button_off = " ",
    button_on = " ",
    up = "",
    down = "",
    right = "",
    left = "",
    outline = "",
}

M.symbol_usage = {
    circle_left = "",
    circle_right = "",
    def = "󰳽 ",
    ref = "󰌹 ",
    impl = "󰡱 ",
}

M.todo_comments = {
    FIX = " ",
    TODO = " ",
    HACK = " ",
    WARN = " ",
    PERF = " ",
    NOTE = " ",
    ERROR = " ",
    REFS = "",
    SHIELD = "",
}

M.languages = {
    c = "",
    rust = "",
    js = "",
    ts = "",
    ruby = "",
    vim = "",
    git = "",
    c_sharp = "",
    python = "",
    go = "",
    java = "",
    kotlin = "",
    toml = "",
}

M.file_icons = {
    Brown = { "" },
    Aqua = { "" },
    LightBlue = { "", "" },
    Blue = { "", "", "", "", "", "", "", "", "", "", "", "", "" },
    DarkBlue = { "", "" },
    Purple = { "", "", "", "", "" },
    Red = { "", "", "", "", "", "" },
    Beige = { "", "", "" },
    Yellow = { "", "", "λ", "", "" },
    Orange = { "", "" },
    DarkOrange = { "", "", "", "", "" },
    Pink = { "", "" },
    Salmon = { "" },
    Green = { "", "", "", "", "", "" },
    LightGreen = { "", "", "", "﵂" },
    White = { "", "", "", "", "", "" },
}

M.nvimtree_icons = {
    default = "",
    symlink = "",
    git = {
        unmerged = "",
        added = "",
        deleted = "",
        modified = "",
        renamed = "󰙏",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
    },
    folder = {
        arrow_closed = "",
        arrow_open = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
}

if lvim.builtin.tree_provider == "neo-tree" then
    M.nvimtree_icons["git"] = {
        unmerged = "",
        added = "",
        deleted = "",
        modified = "",
        renamed = "󰙏",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
    }
end

M.mason = {
    package_pending = " ",
    package_installed = "󰄳 ",
    package_uninstalled = " 󰚌",
}

M.define_dap_signs = function()
    vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
    vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
    vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    -- FIX
    vim.fn.sign_define(
        "DapLogPoint",
        { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
    )
end

M.set_icons = function()
    require("nvim-web-devicons").set_icon {
        toml = {
            icon = "📦",
            color = "#8FAA54",
            name = "Toml",
        },
        rs = {
            icon = "🦀",
            color = "#d28445",
            name = "Rust",
        },
        tf = {
            icon = "",
            color = "#3d59a1",
            name = "Terraform",
        },
        tfvars = {
            icon = "",
            color = "#51afef",
            name = "Terraform",
        },
        mod = {
            icon = "",
            color = "#6a9fb5",
            name = "Mod",
        },
        sum = {
            icon = "",
            color = "#6a9fb5",
            name = "Sum",
        },
        txt = {
            icon = "",
            color = "#bbc2cf",
            name = "Text",
        },
        csv = {
            icon = " ",
            color = "#31B53E",
            name = "CSV",
        },
        plist = {
            icon = "",
            color = "#8FAA54",
            name = "Plist",
        },
        burp = {
            icon = "",
            color = "#F16529",
            name = "Burp",
        },
        mp4 = {
            icon = "",
            color = "#5fd7ff",
            name = "MP4",
        },
        mkv = {
            icon = "",
            color = "#5fd7ff",
            name = "MKV",
        },
        hcl = {
            icon = "",
            color = "#689FB6",
            name = "HCL",
        },
        sol = {
            icon = "",
            color = "#555555",
            name = "Sol",
        },
    }
end

M.use_my_icons = function()
    for _, sign in ipairs(require("user.lsp").default_diagnostic_config.signs.values) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end
    if lvim.builtin.tree_provider == "nvimtree" then
        lvim.builtin.nvimtree.setup.diagnostics.enable = true
        lvim.builtin.nvimtree.setup.renderer.icons.webdev_colors = true
        lvim.builtin.nvimtree.setup.renderer.icons.show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
        }
    end
    if lvim.builtin.bufferline.active then
        lvim.builtin.bufferline.options.show_buffer_icons = true
        lvim.builtin.bufferline.options.show_buffer_close_icons = true
    end
end

return M
