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
		lualine_c = {
			{
				"diagnostic-message",
				--- If you want to custoimze the colors
				colors = {
					error = "#BF616A",
					warn = "#EBCB8B",
					info = "#A3BE8C",
					hint = "#88C0D0",
				},
				--- If you want to custoimze the icons
				icons = {
					error = "E",
					warn = "W",
					info = "I",
					hint = "H",
				},
				-- Replace '\n' by the separator
				line_separator = ". ",

				-- Only show the first line of diagnostic message
				first_line_only = false,
			},
		},
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
