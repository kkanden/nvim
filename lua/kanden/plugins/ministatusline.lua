local default_separator = "|"
local section_separators = { left = "", right = "" }

---@param separator string?
---@param components string[]
---@return string
local combine = function(components, separator)
    separator = separator or default_separator
    local combined = components[1]

    for i = 2, #components do
        combined = combined .. " " .. separator .. " " .. components[i]
    end

    return combined
end

local progress_location = function()
    local cur = vim.fn.line(".")
    local total = vim.fn.line("$")
    local progress = string.format("%3d%%%%", math.floor(cur / total * 100))

    local line = vim.fn.line(".")
    local col = vim.fn.charcol(".")
    local location = string.format("%3d:%2d", line, col)
    return combine({ progress, location })
end

local git_file = function(max_length)
    max_length = max_length or 70
    local rest = "%m%r"
    local path = ""
    if vim.fn.expand("%:~:.") == "" or vim.bo.buftype ~= "" then
        path = "%f" .. rest
    else
        path = vim.fn.expand("%:~:.") .. rest
    end

    if #path > max_length then path = vim.fn.pathshorten(path, 2) end

    local git = MiniStatusline.section_git({ icon = "" })

    if #git > 0 then path = combine({ git, path }) end
    return path
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

local lsp_fileinfo_fun = function()
    local lsp_file
    local lsp = lsp_fun()
    local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 10000 })
    if #lsp > 0 then lsp_file = combine({ lsp, fileinfo }) end
    return lsp_file or fileinfo
end

local statusline = function()
    local mode, mode_hl = MiniStatusline.section_mode({})
    local diagnostic = MiniStatusline.section_diagnostics({})
    local prog_loc = progress_location()
    local git_filename = git_file()
    local lsp_fileinfo = lsp_fileinfo_fun()

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
        "%#MiniStatuslineDevinfo#", lsp_fileinfo,             -- LSP | FILETYPE
        " %#SeparatorA#", section_separators["right"],
        "%#", mode_hl, "#", prog_loc,            -- PROGRESS | LOCATION
    })
    -- stylua: ignore end

    return statusline_string
end

return {
    {
        "echasnovski/mini.statusline",
        enabled = false,
        version = "*",
        opts = {
            content = {
                active = statusline,
            },
        },
    },
}
