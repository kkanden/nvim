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

-- folds
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false
opt.foldcolumn = "0"
function MyFoldText(lnum_start, lnum_end, foldlevel)
    local nlines = lnum_end - lnum_start
    local line = vim.fn.getline(lnum_start)
    local format_string = string.format(
        "%s %%s ...... %%d more lines",
        string.rep("+", foldlevel)
    )
    return string.format(format_string, line, nlines)
end
opt.foldtext = "v:lua.MyFoldText(v:foldstart, v:foldend, v:foldlevel)"

-- keep cursor centered as much as possible
opt.scrolloff = 999

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
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true

-- diagnostics
vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
})

-- WSL clipboard
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank -i",
            ["*"] = "win32yank -i",
        },
        paste = {

            ["+"] = "win32yank -o",
            ["*"] = "win32yank -o",
        },
        cache_enabled = 0,
    }
end
