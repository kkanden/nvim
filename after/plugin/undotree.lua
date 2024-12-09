vim.keymap.set("n", "<leader>u", function()
	vim.cmd.UndotreeToggle()
	vim.cmd("wincmd t")
end)

-- if on windows, use different command
if package.config:sub(1, 1) == "\\" then
	vim.g.undotree_DiffCommand = "FC"
end
