local M = {}

---create custom augroup for this config
---@param name string
---@return integer
M.augroup = function(name)
    return vim.api.nvim_create_augroup("oliwia_" .. name, { clear = true })
end

return M
