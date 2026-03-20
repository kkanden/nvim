-- make plugins reachable by the lsp
local plugin_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site/pack/core/opt")
local plugin_libs = { "$VIMRUNTIME" }

if vim.fs.root(vim.uv.cwd(), ".git") == vim.fn.stdpath("config") then
    for name, type in vim.fs.dir(plugin_dir) do
        if type == "directory" then
            table.insert(plugin_libs, vim.fs.joinpath(plugin_dir, name))
        end
    end
end

return {
    cmd = { "emmylua_ls" },
    filetypes = { "lua" },
    settings = {
        emmylua = {
            workspace = {
                library = plugin_libs,
            },
            runtime = {
                version = "LuaJIT",
                requirePattern = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                    "?/lua/?.lua",
                    "?/lua/?/init.lua",
                },
            },
        },
    },
}
