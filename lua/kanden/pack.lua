local function gh(x) return "https://github.com/" .. x end

local plugins = {
    gh("stevearc/conform.nvim"),
    gh("rafamadriz/friendly-snippets"),
    gh("tpope/vim-fugitive"),
    gh("lewis6991/gitsigns.nvim"),
    gh("kevinhwang91/nvim-hlslens"),
    gh("kkanden/idknotes.nvim"),
    gh("lukas-reineke/indent-blankline.nvim"),
    { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("*") },
    gh("nvim-mini/mini.nvim"),
    gh("kkanden/minipoon.nvim"),
    gh("stevearc/oil.nvim"),
    { src = gh("R-nvim/R.nvim"), version = vim.version.range("*") },
    gh("nvim-treesitter/nvim-treesitter"),
    gh("nvim-treesitter/nvim-treesitter-textobjects"),
    gh("windwp/nvim-ts-autotag"),
    gh("vague2k/vague.nvim"),
}

vim.pack.add(plugins)

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
    -- revert to lockfile
    revert = {
        exec = function()
            vim.pack.update(nil, { offline = true, target = "lockfile" })
        end,
    },
    -- e.g. update rev/version
    refresh = {
        exec = function()
            vim.pack.update(nil, { offline = true, target = "version" })
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
