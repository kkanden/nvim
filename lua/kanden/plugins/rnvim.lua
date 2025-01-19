local buf_map = vim.api.nvim_buf_set_keymap

require("r").setup({
    hook = {
        on_filetype = function()
            buf_map(
                0,
                "n",
                "<localleader>gn",
                "<Cmd>lua require('r.rnw').next_chunk()",
                {}
            )
            buf_map(
                0,
                "n",
                "<localleader>gN",
                "<Cmd>lua require('r.rnw').previous_chunk()",
                {}
            )
            buf_map(0, "v", "<Enter>", "<Plug>RSendSelection", {})

            -- start shiny app (even if one is already running)
            buf_map(
                0,
                "n",
                "<localleader><F5>",
                table.concat({
                    "<C-l>i<C-c><CR><C-z>", -- quit current session and go back to main window
                    "<Cmd>wa<CR><BAR>", -- save all files
                    "<Cmd>lua require('r.send').cmd('shiny::runApp()')<CR>", -- start shiny app
                }),
                {}
            )
        end,
    },
    auto_start = "on startup",
    R_args = { "--quiet", "--no-save" },
    nvimpager = "split_h",
    assignment_keymap = "<C-s>",
    pipe_keymap = "<C-l>",
    min_editor_width = 0,
    rconsole_width = math.floor(vim.o.columns * 0.3),
})
