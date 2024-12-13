vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stick cursor at beginning of line when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor centered when going up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--keep cursor centered when term searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- copy after delete preserves the copied term
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy/paste to/from clipboard shortcut
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>pp", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- useful for visual block insert
vim.keymap.set("i", "<C-c>", "<Esc>")

-- unbind default mappings
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- start replace on word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- start search for word under cursor
vim.keymap.set("n", "<leader>h", "/<C-r><C-w>")

-- Easily exit terminal mode.
vim.keymap.set({ "n", "t" }, "<C-x>", function()
    vim.cmd("stopinsert")
    vim.cmd("wincmd t")
end)

-- movement between splits
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

-- control size of splits
vim.keymap.set("n", "<M-,>", "<C-w>5<")
vim.keymap.set("n", "<M-.>", "<C-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")

-- hide hlsearch
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

-- move to start/end of line in insert mode
-- (if last character is comma, set cursor before the comma)
vim.keymap.set("i", "<C-a>", function()
    local line = vim.api.nvim_get_current_line() -- get cursor position (row, col)
    local col = #line                            -- get length of line
    local char_under_cursor = line:sub(col, col) -- get last character

    if char_under_cursor == "," then
        col = col - 1
    end

    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], col }) -- put cursor in right poisition
end)

vim.keymap.set("i", "<C-i>", "<C-o>I")

-- `q` as alias for `"`
vim.keymap.set({ "o", "v" }, "iq", 'i"')
vim.keymap.set({ "o", "v" }, "aq", 'a"')

-- "ignore case" on write and quit
vim.cmd("command! W write")
vim.cmd("command! Q quit")
