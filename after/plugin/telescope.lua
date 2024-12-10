local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Telescope git files" })
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Telescope grep" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Telescope buffers" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>pn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Telescope neovim config files" })

vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })

require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			".lazy%-lock%.json",
		},
	},
	pickers = {
		buffers = {
			theme = "dropdown",
			previewer = false,
			winblend = 0,
			layout_config = {
				width = 0.5,
				height = 0.5,
			},
		},
		current_buffer_fuzzy_find = {
			theme = "dropdown",
			winblend = 0,
			previewer = false,
			layout_config = {
				width = 0.6,
				height = 0.6,
			},
		},
	},
})
