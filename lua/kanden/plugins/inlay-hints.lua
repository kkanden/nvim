return {
    "MysticalDevil/inlay-hints.nvim",
    ft = { "rust" },
    event = "LspAttach",
    config = function() require("inlay-hints").setup() end,
}
