-- extended `:find` with smarter completion
-- uses fd and fzf

local filescache = {}
local pathcache
local completecache = {}

vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = ":",
    callback = function()
        filescache = {}
        pathcache = nil
        completecache = {}
    end,
})

function FindComplete(arglead, cmdline, _)
    local rest = cmdline:match("^Find%s+(.*)$") or "" -- arguments to Find
    local tokens = vim.fn.split(rest, " ")
    local search_path
    -- the first token is either the pattern for cwd or the search path
    -- if there is a space after the first token, it's the search path
    if rest:match("%s$") or #tokens > 1 then search_path = tokens[1] end

    if #filescache == 0 or search_path ~= pathcache then
        local cmd = { "fd", "-t", "file" }
        if search_path then
            table.insert(cmd, "--base-directory") -- print relative to search_path
            table.insert(cmd, vim.fn.expand(search_path))
        end
        local fd = vim.system(cmd):wait()
        pathcache = search_path
        if fd.code == 0 then filescache = vim.fn.split(fd.stdout, "\n") end
    end

    local fzf_matches = {}
    if arglead ~= "" then
        local fzf = vim.system(
            { "fzf", "--filter", arglead },
            { stdin = table.concat(filescache, "\n") }
        ):wait()
        fzf_matches = fzf.code == 0 and vim.fn.split(fzf.stdout, "\n") or {}
    else
        fzf_matches = filescache
    end

    if not search_path then
        completecache =
            vim.list_extend(fzf_matches, vim.fn.getcompletion(arglead, "file"))
        vim.list.unique(completecache)
    else
        completecache = fzf_matches
    end
    return completecache
end

vim.api.nvim_create_user_command("Find", function(args)
    local tokens = vim.fn.split(args.args, " ")
    local file

    if #tokens == 1 then
        -- file directly
        file = tokens[1]
    else
        -- first token is path, second is the selected file
        file = vim.fn.expand(tokens[1]) .. "/" .. tokens[2]
    end

    vim.cmd("edit " .. file)
end, {
    nargs = "+",
    complete = FindComplete,
})

vim.keymap.set("n", "ff", ":Find ")
vim.keymap.set("n", "<leader>pn", function()
    local dir = vim.fs.dirname(vim.fn.expand("$MYVIMRC"))
    return ":Find " .. dir .. " "
end, { expr = true })
