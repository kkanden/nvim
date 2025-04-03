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

return {
    "theprimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    commit = "e76cb03", -- latest doesn't really work for me, this is good enough
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        settings = {
            save_on_toggle = true,
            key = git_branch_marks,
        },
        default = {
            ---@param config HarpoonPartialConfigItem
            ---@param name? any
            ---@return HarpoonListItem
            create_list_item = function(config, name)
                local file_name =
                    vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
                name = vim.fn.fnamemodify(file_name, ":.")

                local bufnr = vim.fn.bufnr(name, false)

                local pos = { 1, 0 }
                if bufnr ~= -1 then pos = vim.api.nvim_win_get_cursor(0) end

                return {
                    value = name,
                    context = {
                        row = pos[1],
                        col = pos[2],
                    },
                }
            end,
        },
    },
    keys = function()
        local harpoon = require("harpoon")
        local toggle_opts = {
            title = " Harpoon ",
            border = "rounded",
            title_pos = "center",
            ui_width_ratio = 0.4,
        }

        return {
            {
                "<leader>a",
                function() harpoon:list():add() end,
                desc = "Harpoon: add file",
            },

            {
                "<C-e>",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
                end,
                desc = "Harpoon: toggle window",
            },

            {
                "<C-c>",
                function() harpoon.ui:close_menu() end,
                desc = "Harpoon: close window",
            },

            {
                "<Tab>1",
                function() harpoon:list():select(1) end,
                desc = "Harpoon: select file 1",
            },

            {
                "<Tab>2",
                function() harpoon:list():select(2) end,
                desc = "Harpoon: select file 2",
            },

            {
                "<Tab>3",
                function() harpoon:list():select(3) end,
                desc = "Harpoon: select file 3",
            },

            {
                "<Tab>4",
                function() harpoon:list():select(4) end,
                { desc = "Harpoon: select file 4" },
            },
        }
    end,
}
