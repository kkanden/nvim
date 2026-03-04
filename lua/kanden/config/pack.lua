local function gh(x) return "https://github.com/" .. x end

local plugins = {
    { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
    gh("mikavilpas/blink-ripgrep.nvim"),
    gh("catgoose/nvim-colorizer.lua"),
    gh("stevearc/conform.nvim"),
    { src = gh("j-hui/fidget.nvim"), data = { now = true } },
    gh("rafamadriz/friendly-snippets"),
    gh("tpope/vim-fugitive"),
    gh("lewis6991/gitsigns.nvim"),
    gh("kevinhwang91/nvim-hlslens"),
    gh("kkanden/idknotes.nvim"),
    gh("lukas-reineke/indent-blankline.nvim"),
    {
        src = gh("selimacerbas/markdown-preview.nvim"),
        data = { ft = { "markdown", "rmd" } },
    },
    {
        src = gh("selimacerbas/live-server.nvim"),
        data = { ft = { "markdown", "rmd" } },
    },
    { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("*") },
    gh("nvim-mini/mini.nvim"),
    gh("kkanden/minipoon.nvim"),
    { src = gh("stevearc/oil.nvim"), data = { now = true } },
    { src = gh("R-nvim/R.nvim"), data = { ft = { "r", "rmd" } } },
    gh("nguyenvukhang/nvim-toggler"),
    gh("nvim-treesitter/nvim-treesitter-textobjects"),
    gh("windwp/nvim-ts-autotag"),
    { src = gh("vague2k/vague.nvim"), data = { now = true } },
}

vim.list_extend(
    plugins,
    not vim.g.on_nixos and { gh("nvim-treesitter/nvim-treesitter") } or {}
)

---@param plugin string
local function normalize_name(plugin)
    local basename = plugin
        :lower()
        :match("https://.+/.+/([%w_%-%.]+)")
        :gsub("%.%w+$", "")
        :gsub("n?vim%-", "")
    return basename or plugin
end

plugins = vim.iter(plugins)
    :map(function(x)
        if type(x) == "string" then
            return { src = x, name = normalize_name(x) }
        elseif type(x) == "table" then
            return vim.tbl_extend("keep", x, { name = normalize_name(x.src) })
        end
    end)
    :totable()

vim.pack.add(plugins)

-- source setups
local plugins_dir =
    vim.fs.joinpath(vim.fn.stdpath("config"), "lua/kanden/plugins")

-- based on MiniMax config
local misc = require("mini.misc")
local now = function(f) misc.safely("now", f) end
local lazy = function(f) misc.safely("later", f) end
local on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

for name, _ in vim.fs.dir(plugins_dir) do
    local setup = function() dofile(vim.fs.joinpath(plugins_dir, name)) end

    if name:match("_now") then now(setup) end

    local basename = name:gsub("%.lua", "")
    local spec = vim.iter(plugins)
        :filter(function(x) return x.name == basename end)
        :totable()[1] or {}

    -- plugins are lazy by default
    if spec.data and spec.data.now then
        now(setup)
    elseif spec.data and spec.data.ft then
        on_filetype(table.concat(spec.data.ft, ","), setup)
    else
        lazy(setup)
    end
end
