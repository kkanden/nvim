vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(ev)
        local value = ev.data.params.value
        vim.b[ev.buf].lspstatus = value.kind ~= "end" and " " or ""
        vim.cmd("redrawstatus")
    end,
})

local function lsp()
    local lsps = table.concat(
        vim.iter(vim.lsp.get_clients({ bufnr = 0 }))
            :map(function(x) return x.name end)
            :totable(),
        ", "
    )
    return (vim.b.lspstatus or "") .. lsps
end
local function git()
    return vim.b.gitsigns_head ~= nil and vim.b.gitsigns_head or ""
end

local function filename()
    local fname = vim.fn.expand("%:~:.")
    local rest = "%m%r%h"
    -- buftype is empty if it's not a special buffer (e.g. help, qflist)
    if
        fname == ""
        or vim.list_contains(
            { "help", "prompt", "quickfix", "terminal" },
            vim.bo.buftype
        )
    then
        fname = "%t"
    end
    return fname .. rest
end
local function loc() return "%l|%L" end
local function lsp_ft()
    local lsps = lsp()
    local lsps_ft = lsps .. (lsps ~= "" and " | " or "") .. vim.bo.filetype
    return lsps_ft
end

function StatusLine()
    local tab = {
        "%#StatusLine#",
        git(),
        "%#StatusLineNC#",
        filename(),
        "%=",
        loc(),
        "%#StatusLine#",
        lsp_ft(),
    }
    -- remove first and/or last section if they're empty
    if tab[2] == "" then
        table.remove(tab, 1)
        table.remove(tab, 1)
    end

    if tab[#tab] == "" then
        table.remove(tab)
        table.remove(tab)
    end
    local st = table.concat(tab, " ") .. " "
    return st
end
vim.go.statusline = "%!v:lua.StatusLine()"
vim.g.qf_disable_statusline = 1
