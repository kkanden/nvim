local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Telescope git files" })
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Telescope grep" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>pn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 0,
		previewer = false,
		layout_config = {
			width = 0.6,
			height = 0.6,
		},
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
