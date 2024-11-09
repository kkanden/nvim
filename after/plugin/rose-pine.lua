vim.opt.laststatus = 2 -- Or 3 for global statusline
vim.opt.statusline = " %F %m %= %l:%c ♥ "

require("rose-pine").setup({
	variant = "main",

	styles = {
		italic = false,
	},

	highlight_groups = {
		StatusLine = { fg = "love", bg = "love", blend = 10 },
		StatusLineNC = {fg = "subtle", bg = "surface" },
		CurSearch = { fg = "base", bg = "leaf", inherit = false },
		Search = { fg = "text", bg = "leaf", blend = 20, inherit = false},
		TelescopeBorder = { bg = "#AE7FA7", fg = "#000000" },
		TelescopeNormal = { bg = "#AE7FA7", fg = "#000000" },
		TelescopeTitle = { fg = "#000000" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
		TelescopeMatching = { fg = "#4DB6AC" }
	},
})

vim.cmd('colorscheme rose-pine')
