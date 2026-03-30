local augroup = require("kanden.lib").augroup

local installed = require("nvim-treesitter").get_installed()
local parsers = require("nvim-treesitter").get_available()

-- install all parses, idc
-- once they're installed, this is no-op
require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("treesitter"),
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype or ""
        local lang = vim.treesitter.language.get_lang(ft)

        -- run treesitter if we have the parser
        if vim.list_contains(installed, lang) then
            vim.treesitter.start()
            vim.opt.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt.foldmethod = "expr"
        end
    end,
})
