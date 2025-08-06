return {
    "dmtrKovalenko/fff.nvim",
    enabled = vim.fn.has("win32") == 0,
    build = "cargo build --release",
    opts = {
        prompt = " ",
        keymaps = {
            close = { "<Esc>", "<C-c>" },
            select = { "<Enter>", "<C-b>" },
        },
    },
    keys = {
        {
            "<leader>pf",
            ":lua require('fff').find_files()<CR>",
            desc = "FFF: File picker",
        },
    },
}
