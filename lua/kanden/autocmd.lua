local augroup = require("kanden.lib").augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function() vim.highlight.on_yank() end,
})

autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "help",
        "fugitive",
        "git",
        "gitcommit",
        "checkhealth",
        "qf",
        "nvim-undotree",
    },
    callback = function()
        vim.keymap.set("n", "q", "<Cmd>q<CR>", { buffer = true })
    end,
})

autocmd("TermOpen", {
    group = augroup("custom_term_open"),
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.scrolloff = 0
        vim.bo.filetype = "terminal"
    end,
})

autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function() vim.cmd("tabdo wincmd =") end,
})

autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

autocmd({ "QuitPre" }, {
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local filetype =
                vim.api.nvim_get_option_value("buftype", { buf = buf })
            if filetype == "terminal" then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end,
})

autocmd("FileType", {
    group = augroup("text_linebreak"),
    pattern = { "markdown", "tex", "text", "typst" },
    callback = function()
        vim.cmd([[
            setlocal textwidth=80
            setlocal formatoptions+=t
            setlocal linebreak
            setlocal spell
        ]])
    end,
})

autocmd({ "CursorHold", "InsertEnter" }, {
    group = augroup("nohlsearch"),
    callback = function()
        if vim.v.hlsearch == 1 then
            vim.api.nvim_input("<Cmd>nohlsearch<CR>")
        end
    end,
})
