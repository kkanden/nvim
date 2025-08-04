return {
    "dmtrKovalenko/fff.nvim",
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
