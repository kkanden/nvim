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

---Merge two tables, similar to string concatenation
---@param t1 table
---@param t2 table
---@return table
M.merge_tables = function(t1, t2)
    local result = {}
    for k, v in pairs(t1) do
        result[k] = v
    end
    for k, v in pairs(t2) do
        result[k] = v
    end
    return result
end

return M
