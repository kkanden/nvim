local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { silent = true })
vim.keymap.set(
    { "i", "s" },
    "<S-Tab>",
    function() ls.jump(-1) end,
    { silent = true }
)

vim.keymap.set({ "i", "s" }, "<C-s>", function()
    if ls.choice_active() then ls.change_choice(1) end
end, { silent = true })
