-- solution from https://github.com/ThePrimeagen/harpoon/issues/565#issuecomment-2378921076
local git_branch = function()
    local pipe = io.popen("git branch --show-current")
    if pipe then
        local c = pipe:read("*l"):match("^%s*(.-)%s*$")
        pipe:close()
        return c
    end
    return "default"
end

return {
    "theprimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        settings = {
            save_on_toggle = true,
            save_on_ui_close = true,
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

        local list = function() return harpoon:list(git_branch()) end

        return {
            {
                "<leader>a",
                function() list():add() end,
                desc = "Harpoon: add file",
            },

            {
                "<C-e>",
                function() harpoon.ui:toggle_quick_menu(list(), toggle_opts) end,
                desc = "Harpoon: toggle window",
            },

            {
                "<C-c>",
                function() harpoon.ui:close_menu() end,
                desc = "Harpoon: close window",
            },

            {
                "<Tab>1",
                function() list():select(1) end,
                desc = "Harpoon: select file 1",
            },

            {
                "<Tab>2",
                function() list():select(2) end,
                desc = "Harpoon: select file 2",
            },

            {
                "<Tab>3",
                function() list():select(3) end,
                desc = "Harpoon: select file 3",
            },

            {
                "<Tab>4",
                function() list():select(4) end,
                { desc = "Harpoon: select file 4" },
            },
        }
    end,
}
