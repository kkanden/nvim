local map = require("kanden.lib.nvim_api").map
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

map("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>ff", function()
    builtin.find_files({ cwd = "~" }) -- search files in the home directory
end, { desc = "Telescope find files" })
map("n", "<leader>pg", builtin.git_files, { desc = "Telescope git files" })
map("n", "<leader>ps", builtin.live_grep, { desc = "Telescope grep" })
map("n", "<leader>pb", builtin.buffers, { desc = "Telescope buffers" })

-- Shortcut for searching your Neovim configuration files
map(
    "n",
    "<leader>pn",
    function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Telescope neovim config files" }
)

map(
    "n",
    "<leader>/",
    builtin.current_buffer_fuzzy_find,
    { desc = "[/] Fuzzily search in current buffer" }
)

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {
            "lazy%-lock.json",
            ".git",
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
            },
        },
        history = true,
    },
    pickers = {
        buffers = {
            theme = "dropdown",
            previewer = false,
            winblend = 0,
            layout_config = {
                width = 0.5,
                height = 0.5,
            },
        },
        current_buffer_fuzzy_find = {
            theme = "dropdown",
            winblend = 0,
            previewer = false,
            layout_config = {
                width = 0.6,
                height = 0.6,
            },
        },
    },
})
