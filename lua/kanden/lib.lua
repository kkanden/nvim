local M = {}

---create custom augroup for this config
---@param name string
---@return integer
M.augroup = function(name)
    return vim.api.nvim_create_augroup("oliwia_" .. name, { clear = true })
end

---@param mode string|string[]
---@param key string
---@param command string|function
---@param opts? table
M.map = function(mode, key, command, opts)
    opts = opts or {}
    vim.keymap.set(mode, key, command, opts)
end

---Run OS command
---@param cmd string[]
---@param opts? any
---@return string?
---@return integer
---@return string?
M.system_output = function(cmd, opts)
    opts = opts or {}
    local obj = vim.system(cmd, opts):wait()
    return obj.stdout, obj.code, obj.stderr
end

return M
