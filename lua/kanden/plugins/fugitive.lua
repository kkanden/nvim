local map = require("kanden.lib").map

map("n", "<leader>gs", vim.cmd.Git)
map("n", "<leader>gp", "<Cmd>Git pull<CR>")
map("n", "<leader>gd", "<Cmd>Git diff<CR>")
