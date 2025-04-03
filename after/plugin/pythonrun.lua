local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
local system_output = require("kanden.lib").system_output

---Returns terminal command output `stdout, status, stderr`
---@param filename string
---@return string?
---@return integer
---@return string?
local get_python_output = function(filename)
    local stdout, status, stderr = system_output({ "python", filename })
    return stdout, status, stderr
end

---comment
---@param output string[]
---@param status integer
---@param buf integer
local insert_command_output = function(output, status, buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {}) -- clear buffer
    vim.api.nvim_buf_set_lines(buf, 0, #output, false, output)
    vim.api.nvim_buf_set_lines(
        buf,
        -1,
        -1,
        false,
        { ("Process exited with status code %d."):format(status) }
    )
    if status ~= 0 then -- color the output red on error
        for i = 1, #output do
            -- stylua: ignore
            vim.api.nvim_buf_add_highlight(buf, 0, "Error", i - 1, 0, #output[i])
        end
    end
end

---Creates below scratch split
---@param opts? any
---@return table
local create_split = function(opts)
    opts = opts or {}
    local height = math.ceil(vim.o.lines * 0.2)

    local buf
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer
    end

    local win_config = {
        height = height,
        split = "below",
        style = "minimal",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<Cmd>q<CR>", {})
    vim.api.nvim_set_option_value("filetype", "pythonoutput", { buf = buf })

    return { buf = buf, win = win }
end

local state = {
    output = {
        buf = -1,
        win = -1,
    },
}

local run_python = function()
    local filename = vim.api.nvim_buf_get_name(0)
    if not vim.api.nvim_win_is_valid(state.output.win) then
        state.output = create_split({ buf = state.output.buf })
    end
    local stdout, status, stderr = get_python_output(filename)
    local stdout_tbl = stdout ~= "" and vim.split(stdout, "\n") or {}
    local stderr_tbl = stderr ~= "" and vim.split(stderr, "\n") or {}
    local output = vim.tbl_extend("keep", stdout_tbl, stderr_tbl)
    insert_command_output(output, status, state.output.buf)
end

vim.api.nvim_create_user_command("RunPython", run_python, {})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("python_run"),
    pattern = { "python" },
    callback = function()
        map("n", "<localleader><F5>", function()
            vim.cmd("w")
            run_python()
            vim.cmd("wincmd t")
        end, { buffer = 0 })
    end,
})
