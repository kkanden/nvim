require("r").setup({
	hook = {
		on_filetype = function()
			vim.api.nvim_buf_set_keymap(0, "n", "<localleader>gn", "<Plug>RNextRChunk zz", {})
			vim.api.nvim_buf_set_keymap(0, "n", "<localleader>gN", "<Plug>RPreviousRChunk zz", {})

			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<localleader><F5>",
				"<Cmd>lua require('r.send').cmd('shiny::runApp()')<CR>",
				{}
			)
		end,
	},
	auto_start = "on startup",
	pipe_keymap = "<localleader>,",
})
