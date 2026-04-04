if vim.fn.getcwd() == vim.fn.stdpath("config") then
    vim.bo.keywordprg = ":help"
end
