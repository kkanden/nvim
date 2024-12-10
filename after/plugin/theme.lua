-- Rose Pine Theme
-- vim.opt.laststatus = 2 -- Or 3 for global statusline
-- vim.opt.statusline = " %F %m %= %l:%c ♥ "
--
-- require("rose-pine").setup({
-- 	variant = "main",
--
-- 	styles = {
-- 		italic = false,
-- 	},
--
-- highlight_groups = {
-- 	StatusLine = { fg = "love", bg = "love", blend = 10 },
-- 	StatusLineNC = {fg = "subtle", bg = "surface" },
-- 	CurSearch = { fg = "base", bg = "leaf", inherit = false },
-- 	Search = { fg = "text", bg = "leaf", blend = 20, inherit = false},
-- 	TelescopeBorder = { bg = "#AE7FA7", fg = "#000000" },
-- 	TelescopeNormal = { bg = "#AE7FA7", fg = "#000000" },
-- 	TelescopeTitle = { fg = "#000000" },
-- 	TelescopeSelection = { fg = "text", bg = "base" },
-- 	TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
-- 	TelescopeMatching = { fg = "#4DB6AC" }
-- },
-- })
--

-- Catppuccin Theme
require("catppuccin").setup({
	no_italic = true,
	styles = {
		comments = {},
		conditionals = {},
	},
	integrations = {
		ts_rainbow = true,
		harpoon = true,
	},
	color_overrides = {
		mocha = {
			text = "#F4CDE9",
			subtext1 = "#DEBAD4",
			subtext0 = "#C8A6BE",
			overlay2 = "#B293A8",
			overlay1 = "#9C7F92",
			overlay0 = "#866C7D",
			surface2 = "#705867",
			surface1 = "#5A4551",
			surface0 = "#44313B",

			base = "#352939",
			mantle = "#211924",
			crust = "#1a1016",
		},
	},
	custom_highlights = function(colors)
		return {
			TelescopeBorder = { bg = "#AE7FA7", fg = "#000000" },
			TelescopeNormal = { bg = "#AE7FA7", fg = "#000000" },
			TelescopeTitle = { fg = "#000000" },
			TelescopeSelection = { fg = colors.text, bg = colors.base },
			TelescopeSelectionCaret = { fg = colors.rose, bg = colors.rose },
			TelescopeMatching = { fg = "#4DB6AC" },
			HarpoonBorder = { bg = "#AE7FA7", fg = "#000000" },
			HarpoonWindow = { bg = "#AE7FA7", fg = "#000000" },
			NavicText = { bg = "none", fg = "#eedaad" },
		}
	end,
})

vim.cmd("colorscheme catppuccin")
