require("autoclose").setup({
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
