require("lualine").setup({
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
		lualine_c = {},
		lualine_x = {},
		lualine_y = {
			{
				"datetime",
				style = "%H:%M:%S",
			},
		},
		lualine_z = { "location" },
	},
})
