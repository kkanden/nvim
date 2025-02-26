local progress = function()
    local cur = vim.fn.line(".")
    local total = vim.fn.line("$")
    return string.format("%3d%%%%", math.floor(cur / total * 100))
end

local location = function()
    local line = vim.fn.line(".")
    local col = vim.fn.charcol(".")
    return string.format("%3d:%2d", line, col)
end

local file = function(max_length)
    max_length = max_length or 70
    local rest = "%m%r"
    local path = ""
    if vim.fn.expand("%:~:.") == "" or vim.bo.buftype ~= "" then
        path = "%f" .. rest
    else
        path = vim.fn.expand("%:~:.") .. rest
    end

    if #path > max_length then
        return vim.fn.pathshorten(path, 2)
    else
        return path
    end
end

local lsp_fun = function()
    local lsp_client = vim.lsp.get_clients({ bufnr = 0 })
    local lsps = ""
    for i, lsp in ipairs(lsp_client) do
        lsps = lsps .. lsp["name"]
        if i ~= #lsp_client then lsps = lsps .. ", " end
    end
    return lsps
end

local statusline = function()
    local section_separators = { left = "", right = "" }
    local component_separators = "|"
    local mode, mode_hl = MiniStatusline.section_mode({})
    local git = MiniStatusline.section_git({ icon = "" })
    local lsp = lsp_fun()
    local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 10000 })
    local diagnostic = MiniStatusline.section_diagnostics({})
    local progress_location = progress()
        .. " "
        .. component_separators
        .. " "
        .. location()
        .. " "

    local git_filename = file()
    if #git > 0 then
        git_filename = git .. " " .. component_separators .. " " .. git_filename
    end

    local lsp_fileinfo = fileinfo
    if #lsp > 0 then
        lsp_fileinfo = lsp .. " " .. component_separators .. " " .. fileinfo
    end

    local mode_hl_props = vim.api.nvim_get_hl(0, { name = mode_hl })

    vim.api.nvim_set_hl(
        0,
        "MiniStatuslineDevinfo",
        { fg = mode_hl_props.bg, bg = "#252535" }
    )
    vim.api.nvim_set_hl(0, "MiniStatuslineFileName", { bg = "#2a2a37" })
    vim.api.nvim_set_hl(
        0,
        "SeparatorA",
        { fg = mode_hl_props.bg, bg = "#252535" }
    )
    vim.api.nvim_set_hl(0, "SeparatorB", { fg = "#252535", bg = "#2a2a37" })

    -- stylua: ignore start
    local statusline_string = table.concat({
        "%#", mode_hl, "# ", mode:upper(),                -- MODE
        "%#SeparatorA#", section_separators["left"],
        "%#MiniStatuslineDevinfo# ", git_filename,        -- GIT | FILENAME
        " %#SeparatorB#", section_separators["left"],
        "%#MiniStatuslineFileName#", diagnostic,          -- MIDDLE SECTION, DIAGNOSTICS
        "%<%=",                                           -- FLUSH LEFT
        " %#SeparatorB#",  section_separators["right"],
        "%#MiniStatuslineDevinfo#", lsp_fileinfo,             -- FILETYPE
        " %#SeparatorA#", section_separators["right"],
        "%#", mode_hl, "#", progress_location,            -- PROGRESS | LOCATION
    })
    -- stylua: ignore end

    return statusline_string
end

require("mini.statusline").setup({
    content = {
        active = statusline,
    },
})
