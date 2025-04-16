local buf_map = vim.api.nvim_buf_set_keymap

return {
    "R-nvim/R.nvim",
    enabled = false,
    ft = { "r", "rmd" },
    opts = {
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
        auto_quit = false,
        auto_start = "on startup",
        R_args = { "--quiet", "--no-save" },
        -- R_app = "radian",
        nvimpager = "split_h",
        min_editor_width = 0,
        rconsole_width = math.floor(vim.o.columns * 0.3),
        pdfviewer = "chrome",
        open_html = "no",
        open_pdf = "no",
    },
}
