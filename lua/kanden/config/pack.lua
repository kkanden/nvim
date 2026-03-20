local function gh(x) return "https://github.com/" .. x end

---@type (string|vim.pack.Spec)[]
local plugins = {
    { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
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
    gh("nvim-treesitter/nvim-treesitter"),
    gh("nvim-treesitter/nvim-treesitter-textobjects"),
    gh("windwp/nvim-ts-autotag"),
    { src = gh("vague2k/vague.nvim"), data = { now = true } },
}

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

-- user cmds
local subcmds = {
    delete = {
        exec = function()
            local to_delete = vim.iter(vim.pack.get())
                :filter(function(x) return not x.active end)
                :map(function(x) return x.spec.name end)
                :totable()
            if #to_delete > 0 then
                vim.pack.del(to_delete)
            else
                vim.notify("vim.pack: nothing to delete")
            end
        end,
    },
    update = {
        exec = function(args)
            local plugs = vim.list_slice(args.fargs, 2)
            if #plugs == 0 then
                vim.pack.update()
                return
            end
            vim.pack.update(plugs)
        end,
        complete = function(lead) return vim.fn.getcompletion(lead, "packadd") end,
    },
    revert = {
        exec = function()
            vim.pack.update(nil, { offline = true, target = "lockfile" })
        end,
    },
}

vim.api.nvim_create_user_command("Pack", function(args)
    local subcmd = args.fargs[1]
    local defn = subcmds[subcmd]
    if not defn then
        vim.notify("Pack: unknown subcommand " .. subcmd, vim.log.levels.ERROR)
        return
    end
    defn.exec(args)
end, {
    nargs = "+",
    complete = function(lead, line, _pos)
        local parts = vim.split(line, "%s+")
        if #parts <= 2 then
            return vim.tbl_filter(
                function(x) return x:find(lead) == 1 end,
                vim.tbl_keys(subcmds)
            )
        end

        local subcmd = parts[2]
        local defn = subcmds[subcmd]
        if defn and defn.complete then return defn.complete(lead) end
    end,
})
