local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zzzv")
map("n", "<C-u>", "<C-u>zzzv")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>Y", [["+Y]])
map("i", "<C-c>", "<Esc>")
map({ "n", "t" }, "<C-z>", "<Cmd>stopinsert | wincmd t<CR>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")
map({ "n", "t" }, "<M-,>", "<C-w>5<")
map({ "n", "t" }, "<M-.>", "<C-w>5>")
map({ "n", "t" }, "<M-t>", "<C-W>+")
map({ "n", "t" }, "<M-s>", "<C-W>-")
map("ca", "W", "w")
map("ca", "Wq", "wq")
map("ca", "Wqa", "wq")
map("ca", "Q", "q")
map("ca", "Qa", "qa")
map("n", "gl", ":silent grep ")
map("t", "<C-n>", "<C-\\><C-n>")
map({ "n", "v" }, "<leader>c", "1z=")
map("n", "mk", "<Cmd> silent wall | make<CR>")

map("n", "Q", function()
    local windows = vim.fn.getwininfo()
    local qfopen = vim.iter(windows):any(function(x) return x.quickfix == 1 end)
    return qfopen and "<Cmd>cclose<CR>" or "<Cmd>copen<CR>"
end, { expr = true })

map({ "i", "n" }, "<C-a>", function()
    local line = vim.api.nvim_get_current_line()
    local col = #line
    local char_under_cursor = line:sub(col, col)

    if vim.tbl_contains({ ",", ";" }, char_under_cursor) then col = col - 1 end

    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], col }) -- put cursor in right poisition
end)

map(
    "n",
    "L",
    function() vim.diagnostic.open_float(nil, { focusable = true }) end,
    { desc = "Show diagnostic float" }
)

map({ "n" }, "<leader>st", function()
    local current = vim.o.spelllang
    if current == "en" then
        vim.o.spelllang = "pl"
        vim.o.spellfile = os.getenv("HOME")
            .. "/.local/state/nvim/spell/pl.utf-8.add"
        vim.cmd("echo 'Spelllang set to pl'")
    else
        vim.o.spelllang = "en"
        vim.o.spellfile = os.getenv("HOME")
            .. "/.local/state/nvim/spell/en.utf-8.add"
        vim.cmd("echo 'Spelllang set to en'")
    end
end)

map(
    "n",
    "gk",
    function()
        vim.cmd(
            string.format(
                "%s %s",
                vim.bo.keywordprg ~= "" and vim.bo.keywordprg
                    or vim.o.keywordprg,
                vim.fn.expand("<cword>")
            )
        )
    end
)
