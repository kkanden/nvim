-- Read user assets, useful for creating file skeletons that are not good for snippets.
-- Assets are stored in assets/ at project root

-- initialize assets table
local assets = {}
for name, type in vim.fs.dir(vim.fn.stdpath("config") .. "/assets") do
    if type == "file" then table.insert(assets, name) end
end

-- complete function
local complete_assets = function(arg_lead, cmd_line, cursor_pos)
    local matches = {}
    for _, asset in ipairs(assets) do
        if asset:lower():find(arg_lead:lower(), 1, true) then
            table.insert(matches, asset)
        end
    end
    return matches
end

vim.api.nvim_create_user_command("ReadAsset", function(opts)
    arg = opts.args or nil
    if not vim.tbl_contains(assets, arg) then
        vim.api.nvim_echo({ { "Not an asset", "Error" } }, true, {})
        return
    end

    local asset = vim.fs.normalize(
        string.format("%s/assets/%s", vim.fn.stdpath("config"), arg)
    )

    vim.cmd("0read " .. asset)
end, { nargs = 1, complete = complete_assets })
