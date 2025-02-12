local map = require("kanden.lib").map

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- stick cursor at beginning of line when joining lines
map("n", "J", "mzJ`z")

-- keep cursor centered when going up and down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

--keep cursor centered when term searching
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- copy after delete preserves the copied term
map("x", "<leader>p", [["_dP]])

-- copy/paste to/from clipboard shortcut
map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>cp", [["+p]])

map({ "n", "v" }, "<leader>d", '"_d')

-- useful for visual block insert
map("i", "<C-c>", "<Esc>")

-- unbind default mappings
map("n", "Q", "<nop>")

--map("n", "<C-k>", "<cmd>cnext<CR>zz")
--map("n", "<C-j>", "<cmd>cprev<CR>zz")
--map("n", "<leader>k", "<cmd>lnext<CR>zz")
--map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- start replace on word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- start search for word under cursor
map("n", "<leader>h", "/<C-r><C-w>")

-- Easily exit terminal mode.
map({ "n", "t" }, "<C-z>", function()
    vim.cmd("stopinsert")
    vim.cmd("wincmd t")
end)

-- movement between splits
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")

-- control size of splits
map({ "n", "t" }, "<M-,>", "<C-w>5<")
map({ "n", "t" }, "<M-.>", "<C-w>5>")
map({ "n", "t" }, "<M-t>", "<C-W>+")
map({ "n", "t" }, "<M-s>", "<C-W>-")

-- hide hlsearch
map("n", "<C-g>", "<cmd>nohlsearch<CR>")

-- move to start/end of line in insert mode
-- (if last character is comma, set cursor before the comma)
map("i", "<C-a>", function()
    local line = vim.api.nvim_get_current_line() -- get cursor position (row, col)
    local col = #line -- get length of line
    local char_under_cursor = line:sub(col, col) -- get last character

    if char_under_cursor == "," then col = col - 1 end

    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], col }) -- put cursor in right poisition
end)

map("i", "<C-i>", "<C-o>I")

-- "ignore case" on write and quit
map("ca", "W", "w")
map("ca", "Wq", "wq")
map("ca", "Wqa", "wq")
map("ca", "Q", "q")
map("ca", "Qa", "qa")

-- easy exit terminal mode and stay in terminal window
map("t", "<C-n>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- show diagnostic popup
map(
    "n",
    "L",
    function() vim.diagnostic.open_float(nil, { focusable = true }) end
)
