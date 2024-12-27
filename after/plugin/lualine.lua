local rstt =
{
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

require("lualine").setup({
    extensions = { "fugitive" },
    options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "filename",
                path = 1, -- relative path
                symbols = {
                    modified = "[+]",
                    readonly = "[-]",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                },
            },
        },
        lualine_c = {
            {
                "diagnostic-message",
                --- If you want to custoimze the colors
                colors = {
                    error = "#BF616A",
                    warn = "#EBCB8B",
                    info = "#A3BE8C",
                    hint = "#88C0D0",
                },
                --- If you want to custoimze the icons
                icons = {
                    error = "E",
                    warn = "W",
                    info = "I",
                    hint = "H",
                },
                -- Replace '\n' by the separator
                line_separator = ". ",

                -- Only show the first line of diagnostic message
                first_line_only = false,
            },
        },
        lualine_x = {},
        lualine_y = {
            { -- R nvimcom status
                rstatus,
                color = rsttcolor
            },
            "filetype",
        },
        lualine_z = { "progress", "location" },
    },
})
