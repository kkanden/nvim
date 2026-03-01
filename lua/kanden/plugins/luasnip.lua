local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
local snippet_path = vim.fn.stdpath("config") .. "/lua/kanden/snippets"

require("luasnip").setup({
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({
    paths = { snippet_path },
})

map(
    { "i", "s" },
    "<C-s>",
    function() require("luasnip").expand_or_jump() end,
    { silent = true }
)
map(
    { "i", "s" },
    "<Tab>",
    function() require("luasnip").jump(1) end,
    { silent = true }
)
map(
    { "i", "s" },
    "<S-Tab>",
    function() require("luasnip").jump(-1) end,
    { silent = true }
)

require("luasnip").filetype_extend("markdown", { "tex" })
require("luasnip").filetype_extend("rmd", { "tex" })
-- load custom markdown snippets to rmd
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rmd",
    group = augroup("md_snippet_in_rmd"),
    callback = function()
        local markdown_snippets = dofile(snippet_path .. "/markdown.lua")
        require("luasnip").add_snippets("rmd", markdown_snippets)
    end,
})
