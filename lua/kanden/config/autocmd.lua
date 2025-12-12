local augroup = require("kanden.lib").augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight when yanking (copying) text -- from kickstart
autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    desc = "Highlight when yanking (copying) text",
    callback = function() vim.highlight.on_yank() end,
})

-- easier quit in filetypes
autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = { "help", "fugitive", "git", "gitcommit", "checkhealth", "qf" },
    callback = function()
        vim.keymap.set("n", "q", "<Cmd>q<CR>", { buffer = true })
    end,
})

-- Set local settings for terminal buffers
autocmd("TermOpen", {
    group = augroup("custom_term_open"),
    callback = function()
        local set = vim.opt_local
        set.number = false
        set.relativenumber = false
        set.scrolloff = 0

        vim.bo.filetype = "terminal"
    end,
})

-- Show only WARN and ERROR diagnostics in R
autocmd("FileType", {
    group = augroup("r_diagnostics"),
    pattern = { "r" },
    callback = function()
        vim.diagnostic.config({
            virtual_text = {
                severity = { min = vim.diagnostic.severity.ERROR },
            },
            signs = { severity = { min = vim.diagnostic.severity.WARN } },
            underline = { severity = { min = vim.diagnostic.severity.ERROR } },
        })
    end,
})

-- formatting options
autocmd("BufEnter", {
    group = augroup("no_comment_continue"),
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } -- disable comment continuation on new line
    end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function() vim.cmd("tabdo wincmd =") end,
})

-- go to last loc when opening a buffer
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

-- fix E948/E676 on `:wqa` with open terminal buffers
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

-- R code folding

function RFoldComment(lnum)
    local line = vim.fn.getline(lnum)
    if string.match(line, "^```{?%w+") then
        return ">1"
    elseif string.match(line, "^```") then
        return "<1"
    elseif string.match(line, "^#%s*.*%s*-+%s*#*$") then
        return ">2"
    end
    return "="
end

autocmd("BufEnter", {
    group = augroup("r_code_folding"),
    callback = function()
        if not vim.tbl_contains({ "r", "rmd" }, vim.bo.filetype) then return end
        vim.opt_local.foldexpr = "v:lua.RFoldComment(v:lnum)"
        vim.opt_local.foldmethod = "expr"
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

-- turn off hlsearch after vim.opt.updatetime or entering insert mode
autocmd({ "CursorHold", "InsertEnter" }, {
    group = augroup("nohlsearch"),
    callback = function()
        if vim.v.hlsearch == 1 then
            vim.api.nvim_input("<Cmd>nohlsearch<CR>")
        end
    end,
})
