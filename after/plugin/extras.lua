vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", "<Cmd>Undotree<CR>", { desc = "Undotree" })

require("vim._core.ui2").enable({})
