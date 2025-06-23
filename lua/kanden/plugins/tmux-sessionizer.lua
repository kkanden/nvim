return {
    "kkanden/tmux-sessionizer.nvim",
    enabled = vim.fn.has("win32") == 0,
    opts = {
        directories = { "~/.config", "~/school", "~/projects" },
        max_depth = 2,
        add_to_list = { "/etc/nixos" },
    },
    keys = {
        {
            "<leader>t",
            "<Cmd>Tmux<CR>",
        },
    },
}
