require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"filename",
				path = 1, -- relative path
			},
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
})
