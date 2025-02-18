local map = require("kanden.lib").map

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

local function create_floating_windows(opts)
    opts = opts or {}
    local width = math.ceil(vim.o.columns * 0.7)
    local height = math.ceil(vim.o.lines * 0.6)

    -- center
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer
    end

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
        title = " Terminal ",
        title_pos = "center",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_windows({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            if vim.fn.has("win32") == 1 then -- if on windows, run powershell
                vim.cmd.terminal("powershell -NoLogo")
            else
                vim.cmd.terminal()
            end
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
        vim.api.nvim_feedkeys("<C-c>", "n", false) -- exit input mode on exit
    end
    vim.api.nvim_feedkeys("i", "n", false) -- switch to input mode on open
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
map({ "n", "t" }, "c\\", toggle_terminal, { desc = "Toggle terminal" })
