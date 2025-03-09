local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
local merge_table = require("kanden.lib").merge_tables

---Run OS command
---@param cmd string[]
---@param opts? any
---@return string?
---@return integer
---@return string?
local get_os_command_output = function(cmd, opts)
    opts = opts or {}
    local obj = vim.system(cmd, opts):wait()
    return obj.stdout, obj.code, obj.stderr
end

---Returns terminal command output `stdout, status, stderr`
---@param filename string
---@return string?
---@return integer
---@return string?
local get_python_output = function(filename)
    local stdout, status, stderr = get_os_command_output({ "python", filename })
    return stdout, status, stderr
end

---comment
---@param output string[]
---@param status integer
---@param buf integer
local insert_command_output = function(output, status, buf)
    vim.api.nvim_buf_set_lines(buf, 0, #output, false, output)
    if status ~= 0 then
        vim.api.nvim_buf_add_highlight(buf, 0, "Error", 0, 0, 1000)
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
    vim.api.nvim_buf_set_lines(
        state.output.buf,
        -1,
        -1,
        false,
        { ("Process exited with status code %d."):format(status) }
    )
end

vim.api.nvim_create_user_command("RunPython", run_python, {})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("python_run"),
    pattern = { "python" },
    callback = function()
        vim.keymap.set("n", "<localleader><F5>", function()
            vim.cmd("w")
            run_python()
            vim.cmd("wincmd t")
        end, { buffer = 0 })
    end,
})
