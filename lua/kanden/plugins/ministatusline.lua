local rstt = {
    { "-", "#aaaaaa" }, -- 1: ftplugin/* sourced, but nclientserver not started yet.
    { "S", "#757755" }, -- 2: nclientserver started, but not ready yet.
    { "S", "#117711" }, -- 3: nclientserver is ready.
    { "S", "#ff8833" }, -- 4: nclientserver started the TCP server
    { "S", "#3388ff" }, -- 5: TCP server is ready
    { "R", "#ff8833" }, -- 6: R started, but nvimcom was not loaded yet.
    { "R", "#3388ff" }, -- 7: nvimcom is loaded.
}

local rstatus = function()
    if not vim.g.R_Nvim_status or vim.g.R_Nvim_status == 0 then
        -- No R file type (R, Quarto, Rmd, Rhelp) opened yet
        return ""
    end
    return rstt[vim.g.R_Nvim_status][1]
end

local rsttcolor = function()
    if not vim.g.R_Nvim_status or vim.g.R_Nvim_status == 0 then
        -- No R file type (R, Quarto, Rmd, Rhelp) opened yet
        return { fg = "#000000" }
    end
    return { fg = rstt[vim.g.R_Nvim_status][2] }
end

local progress = function()
    local cur = vim.fn.line(".")
    local total = vim.fn.line("$")
    if cur == 1 then
        return "Top"
    elseif cur == total then
        return "Bot"
    else
        return string.format("%2d%%%%", math.floor(cur / total * 100))
    end
end

local location = function()
    local line = vim.fn.line(".")
    local col = vim.fn.charcol(".")
    return string.format("%d:%d", line, col)
end

local file = function(max_length)
    max_length = max_length or 70
    local rest = "%m%r"
    local path = ""
    if vim.fn.expand("%:~:.") == "" or vim.bo.buftype ~= "" then
        path = "%t" .. rest
    else
        path = vim.fn.expand("%:~:.") .. rest
    end

    if #path > max_length then
        return vim.fn.pathshorten(path, 2)
    else
        return path
    end
end

local statusline = function()
    local section_separators = { left = "", right = "" }
    local component_separators = "|"
    local mode, mode_hl = MiniStatusline.section_mode({})
    local git = MiniStatusline.section_git({ icon = "" })
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
        "%#", mode_hl, "# ", mode:upper(), "%#SeparatorA#",          -- MODE
        section_separators["left"],
        "%#MiniStatuslineDevinfo# ", git_filename, " %#SeparatorB#", -- GIT | FILENAME
        section_separators["left"],
        "%#MiniStatuslineFileName#", diagnostic,                     -- MIDDLE SECTION, DIAGNOSTICS
        "%<%=",                                                      -- FLUSH LEFT
        "%#MiniStatuslineDevinfo#", fileinfo,                        -- FILETYPE
        " %#SeparatorA#", section_separators["right"],
        "%#", mode_hl, "#", progress_location,                       -- PROGRESS | LOCATION
    })
    -- stylua: ignore end

    return statusline_string
end

require("mini.statusline").setup({
    content = {
        active = statusline,
    },
})
