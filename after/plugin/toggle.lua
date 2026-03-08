local map = require("kanden.lib").map

local invs = {
    TRUE = "FALSE",
    ["true"] = "false",
    True = "False",
    yes = "no",
    on = "off",
    enable = "disable",
}
-- add reverse lookup
for k, v in pairs(invs) do
    invs[v] = k
end

local function replace_word()
    local cword = vim.fn.expand("<cword>")
    if not vim.tbl_contains(vim.tbl_keys(invs), cword) then
        vim.notify("nothing to toggle", vim.log.levels.INFO)
        return
    end
    local line = vim.api.nvim_get_current_line()
    local crow = unpack(vim.api.nvim_win_get_cursor(0))
    local wstart, wend = line:find(cword)
    local newline = line:sub(1, wstart - 1) .. invs[cword] .. line:sub(wend + 1)
    vim.api.nvim_buf_set_lines(0, crow - 1, crow, false, { newline })
end

map("n", "<leader>i", function() replace_word() end, { desc = "Toggle" })
