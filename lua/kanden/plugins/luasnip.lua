return {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/snippets" },
        })
        ls.filetype_extend("rmd", { "markdown" })

        local map = require("kanden.lib").map

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
    end,
}
