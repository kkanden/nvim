require("r").setup({
    hook = {
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>gn", "<Plug>RNextRChunk zz", {}),
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>gN", "<Plug>RPreviousRChunk zz", {}),
    },
    auto_start = "on startup",
    pipe_keymap = "<C-g>",
})
