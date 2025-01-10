local opt = vim.opt
opt.number = true
opt.relativenumber = true

opt.ignorecase = true -- ignore case as default search
opt.smartcase = true -- case sensitive search if input contains uppercase

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.termguicolors = true

opt.hlsearch = true
opt.incsearch = true

-- highlight current line number
opt.cursorline = true
opt.cursorlineopt = "number"

opt.scrolloff = 8
opt.signcolumn = "auto"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

-- Highlight when yanking (copying) text -- from kickstart
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

-- Terminal setup
local set = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function()
        set.number = false
        set.relativenumber = false
        set.scrolloff = 0

        vim.bo.filetype = "terminal"
    end,
})

-- netrw options
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "name"
vim.g.netrw_sizestyle = "H"

-- Show only WARN and ERROR diagnostics in R and Rmd
local function set_r_diagnostics()
    vim.diagnostic.config({
        virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
        signs = { severity = { min = vim.diagnostic.severity.WARN } },
        underline = { severity = { min = vim.diagnostic.severity.ERROR } },
    })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "r", "rmd" },
    callback = set_r_diagnostics,
})

opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~") .. "/.vim/undodir"
opt.undofile = true

-- formatting options
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        opt.formatoptions = opt.formatoptions - { "c", "r", "o" } -- disable comment continuation on new line
    end,
})
