return {
    url = "kkanden/idknotes.nvim",
    dir = "~/code/idknotes.nvim",
    dev = false,
    config = function()
        local idknotes = require("idknotes")

        idknotes.setup()

        vim.keymap.set("n", "<leader>n", idknotes.toggle_notes)

        vim.keymap.set(
            "n",
            "<leader>m",
            function() idknotes.toggle_notes(false) end
        )
    end,
}
