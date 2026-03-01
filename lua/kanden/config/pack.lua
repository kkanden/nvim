local function gh(x) return "https://github.com/" .. x end

local plugins = {
    gh("windwp/nvim-ts-autotag"),

    { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
    { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("*") },
    gh("rafamadriz/friendly-snippets"),
    gh("mikavilpas/blink-ripgrep.nvim"),

    gh("catgoose/nvim-colorizer.lua"),

    gh("stevearc/conform.nvim"),

    gh("j-hui/fidget.nvim"),

    gh("tpope/vim-fugitive"),

    gh("sindrets/diffview.nvim"),

    gh("lewis6991/gitsigns.nvim"),

    gh("kevinhwang91/nvim-hlslens"),

    gh("kkanden/idknotes.nvim"),

    gh("lukas-reineke/indent-blankline.nvim"),

    gh("folke/lazydev.nvim"),

    gh("selimacerbas/markdown-preview.nvim"),
    gh("selimacerbas/live-server.nvim"),

    gh("bullets-vim/bullets.vim"),

    gh("nvim-mini/mini.nvim"),

    gh("kkanden/minipoon.nvim"),

    gh("stevearc/oil.nvim"),

    gh("R-nvim/R.nvim"),

    gh("kylechui/nvim-surround"),

    gh("vague2k/vague.nvim"),

    gh("nguyenvukhang/nvim-toggler"),

    gh("nvim-treesitter/nvim-treesitter-textobjects"),

    gh("lervag/vimtex"),
}

vim.list_extend(
    plugins,
    not vim.g.on_nixos and gh("nvim-treesitter/nvim-treesitter") or {}
)

vim.pack.add(plugins)

-- source setups
local plugins_dir =
    vim.fs.joinpath(vim.fn.stdpath("config"), "lua/kanden/plugins")

for name, _ in vim.fs.dir(plugins_dir) do
    dofile(vim.fs.joinpath(plugins_dir, name))
end
