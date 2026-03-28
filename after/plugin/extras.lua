local map = require("kanden.lib").map

vim.cmd("packadd nvim.undotree")
map("n", "<leader>u", "<Cmd>Undotree<CR>", { desc = "Undotree" })

require("vim._core.ui2").enable({})
