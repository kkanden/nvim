local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.ignorecase = true -- ignore case as default search
opt.smartcase = true -- case sensitive search if input contains uppercase

-- global statusline
opt.laststatus = 3

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

-- netrw options
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "name"
vim.g.netrw_sizestyle = "H"

opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~") .. "/.vim/undodir"
opt.undofile = true

-- diagnostics
vim.diagnostic.config({
    severity_sort = true,
})
