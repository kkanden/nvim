local augroup = require("kanden.lib").augroup
local map = require("kanden.lib").map
local snippet_path = vim.fn.stdpath("config") .. "/lua/kanden/snippets"

return {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")

<<<<<<< HEAD
        ls.setup({
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })
=======
        ls.setup({ enable_autosnippets = true })
>>>>>>> 5e3925e (luasnip: enable autosnippets)

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { snippet_path },
        })

        map({ "i", "s" }, "<Tab>", function()
            if ls.expand_or_jumpable() then ls.expand_or_jump() end
        end, { silent = true })
        map(
            { "i", "s" },
            "<S-Tab>",
            function() ls.jump(-1) end,
            { silent = true }
        )
        map({ "i", "s" }, "<C-s>", function()
            if ls.choice_active() then ls.change_choice(1) end
        end, { silent = true })

        ls.filetype_extend("markdown", { "tex" })
        ls.filetype_extend("rmd", { "tex" })
        -- load custom markdown snippets to rmd
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rmd",
            group = augroup("md_snippet_in_rmd"),
            callback = function()
                local markdown_snippets =
                    dofile(snippet_path .. "/markdown.lua")
                ls.add_snippets("rmd", markdown_snippets)
            end,
        })
    end,
}
