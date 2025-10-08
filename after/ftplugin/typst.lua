local function toggle_math()
    local location = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local match = string.match(line, "%$(.*)%$")

    if not match then return end

    local new_expr
    if string.sub(match, 1, 1) == " " then
        new_expr = string.match(match, " (.*) ")
    else
        new_expr = " " .. match .. " "
    end
    local new_line = string.gsub(line, "%$(.*)%$", "$" .. new_expr .. "$")
    vim.api.nvim_buf_set_lines(
        0,
        location[1] - 1,
        location[1],
        false,
        { new_line }
    )
end

vim.keymap.set("n", "<leader>tm", toggle_math, { buffer = 0 })
