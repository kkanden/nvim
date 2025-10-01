local map = require("kanden.lib").map

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- stick cursor at beginning of line when joining lines
map("n", "J", "mzJ`z", { desc = "Stick cursor when joining lines" })

-- stay centered
local keys = {
    "<C-d>",
    "<C-u>",
    "n",
    "N",
}

for _, key in ipairs(keys) do
    map("n", key, key .. "zzzv", {})
end

-- copy after delete preserves the copied term
map(
    "x",
    "<leader>p",
    [["_dP]],
    { desc = "Retain copied item after pasting onto selection" }
)

-- copy/paste to/from clipboard shortcut
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>cp", [["+p]], { desc = "Paste from clipboard" })

map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void registry" })

-- useful for visual block insert
map("i", "<C-c>", "<Esc>", { desc = "Exit visual block mode" })

-- unbind default mappings
map("n", "Q", "<nop>", { desc = "Unbind Q" })

-- start replace on word under cursor
map(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" }
)

-- start search for word under cursor
map("n", "<leader>h", "/<C-r><C-w>", { desc = "Search word under cursor" })

-- Easily exit terminal mode.
map({ "n", "t" }, "<C-z>", function()
    vim.cmd("stopinsert")
    vim.cmd("wincmd t")
end, { desc = "Exit terminal mode and move cursor to topright buffer" })

-- movement between splits
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move down split" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move up split" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move right split" })
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move left split" })

-- control size of splits
map({ "n", "t" }, "<M-,>", "<C-w>5<", { desc = "Resize split" })
map({ "n", "t" }, "<M-.>", "<C-w>5>", { desc = "Resize split" })
map({ "n", "t" }, "<M-t>", "<C-W>+", { desc = "Resize split" })
map({ "n", "t" }, "<M-s>", "<C-W>-", { desc = "Resize split" })

-- hide hlsearch
map("n", "<C-g>", "<cmd>nohlsearch<CR>", { desc = "Hide search highlight" })

-- move to start/end of line in insert mode
-- (if last character is comma, set cursor before the comma)
map({ "i", "n" }, "<C-a>", function()
    local line = vim.api.nvim_get_current_line() -- get cursor position (row, col)
    local col = #line -- get length of line
    local char_under_cursor = line:sub(col, col) -- get last character

    if char_under_cursor == "," then col = col - 1 end

    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], col }) -- put cursor in right poisition
end, { desc = "Move to end of line in insert mode" })

map("i", "<C-i>", "<C-o>I", { desc = "Move to start of line in insert mode" })

-- "ignore case" on write and quit
map("ca", "W", "w", { desc = "Dummy" })
map("ca", "Wq", "wq", { desc = "Dummy" })
map("ca", "Wqa", "wq", { desc = "Dummy" })
map("ca", "Q", "q", { desc = "Dummy" })
map("ca", "Qa", "qa", { desc = "Dummy" })

-- easy exit terminal mode and stay in terminal window
map("t", "<C-n>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- show diagnostic popup
map(
    "n",
    "L",
    function() vim.diagnostic.open_float(nil, { focusable = true }) end,
    { desc = "Show diagnostic float" }
)

-- toggle diagnostic virtual lines/text
map("n", "gK", function()
    local new_text = not vim.diagnostic.config().virtual_text
    local new_lines = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({
        virtual_text = new_text,
        virtual_lines = new_lines,
    })
end, { desc = "Toggle virtual text/lines" })
map({ "n", "v" }, "<leader>cc", "1z=")
