require("r").setup({
    hook = {
        on_filetype = function()
            vim.api.nvim_buf_set_keymap(0, "n", "<localleader>gn", "<Cmd>lua require('r.rnw').next_chunk()", {})
            vim.api.nvim_buf_set_keymap(0, "n", "<localleader>gN", "<Cmd>lua require('r.rnw').previous_chunk()", {})
            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})

            -- start shiny app
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "<localleader><F5>",
                "<Cmd>wa<CR> <BAR> <Cmd>lua require('r.send').cmd('shiny::runApp()')<CR>",
                {}
            )

            -- restart shiny app if one is running
            vim.api.nvim_buf_set_keymap(0, "n", "<localleader><F6>", "<C-w>li<C-c><C-z><localleader><F5>", {})
        end,
    },
    auto_start = "on startup",
    R_args = { "--quiet", "--no-save" },
    nvimpager = "split_h",
    assignment_keymap = "<C-s>",
    pipe_keymap = "<C-f>",
    min_editor_width = 0,
    rconsole_width = math.floor(vim.o.columns * 0.3),
})
