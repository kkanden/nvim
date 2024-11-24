require("autoclose").setup({
	options = {
		disabled_filetypes = {
			"text",
		},
	},
	keys = {
		["$"] = {
			escape = true,
			close = true,
			pair = "$$",
			enabled_filetypes = {
				"rmd",
				"latex",
				"plaintex",
				"context",
			},
		},
	},
})
