require("stay-centered").setup({})

vim.keymap.set(
    { "n", "v" },
    "<leader>sc",
    require("stay-centered").toggle,
    { desc = "Toggle stay-centered.nvim" }
)
