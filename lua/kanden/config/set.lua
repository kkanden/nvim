local o = vim.o

o.backup = false
o.colorcolumn = "80"
o.cursorline = true-- highlight current line number
o.cursorlineopt = "number"
o.expandtab = true
o.formatoptions = "tqj"
o.grepprg = "rg --vimgrep --hidden --smart-case --glob=!.git"
o.hlsearch = true
o.ignorecase = true -- ignore case as default search
o.incsearch = true
o.laststatus = 3-- global statusline
o.number = true
o.relativenumber = true
o.scrolloff = 999
o.shiftwidth = 4
o.signcolumn = "auto"
o.smartcase = true -- case sensitive search if input contains uppercase
o.smartindent = true
o.softtabstop = 4
o.swapfile = false
o.tabstop = 4
o.termguicolors = true
o.undodir = vim.fn.stdpath("state") .. "/undo"
o.undofile = true
o.updatetime = 1000
o.winborder = "single"
vim.cmd("set isfname+=@-@")
vim.cmd("set path+=**")

-- folds
o.foldenable = false
o.foldcolumn = "0"
function MyFoldText(lnum_start, lnum_end, foldlevel)
    local nlines = lnum_end - lnum_start
    local line = vim.fn.getline(lnum_start)
    local format_string = string.format(
        "%s %%s ...... %%d more lines",
        string.rep("+", foldlevel)
    )
    return string.format(format_string, line, nlines)
end
o.foldtext = "v:lua.MyFoldText(v:foldstart, v:foldend, v:foldlevel)"

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = false,
    underline = false,
})

