return {
    "kkanden/tmux-sessionizer.nvim",
    enabled = vim.fn.has("win32") == 0,
    dev = true,
    opts = {
        directories = { "~/.config", "~/code", "~/school", "~/dotfiles" },
        max_depth = 2,
    },
    keys = {
        {
            "<leader>t",
            "<Cmd>Tmux<CR>",
        },
    },
}
