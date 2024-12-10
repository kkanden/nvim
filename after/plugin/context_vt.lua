require("nvim_context_vt").setup({
	min_rows = 4,
})

vim.keymap.set("n", "co", "<Cmd>NvimContextVtToggle<CR>")
