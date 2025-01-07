local harpoon = require("harpoon")
local job = require("plenary.job")

local function get_os_command_output(cmd, cwd)
    if type(cmd) ~= "table" then return {} end
    local command = table.remove(cmd, 1)
    local stderr = {}
    local stdout, ret = job:new({
        command = command,
        args = cmd,
        cwd = cwd,
        on_stderr = function(_, data) table.insert(stderr, data) end,
    }):sync()
    return stdout, ret, stderr
end

local function git_branch_marks()
    local branch = get_os_command_output({
        "git",
        "rev-parse",
        "--abbrev-ref",
        "HEAD",
    })[1]

    if branch then
        return vim.fn.getcwd() .. "-" .. branch
    else
        return vim.fn.getcwd()
    end
end

harpoon:setup({
    settings = {
        save_on_toggle = true,
        key = git_branch_marks,
    },
})

local toggle_opts = {
    title = " Harpoon ",
    border = "rounded",
    title_pos = "center",
    ui_width_ratio = 0.4,
}

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)
vim.keymap.set("n", "<C-c>", function() harpoon.ui:close_menu() end)

vim.keymap.set("n", "w1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "w2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "w3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "w4", function() harpoon:list():select(4) end)
