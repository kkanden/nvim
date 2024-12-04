vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true -- ignore case as default search
vim.opt.smartcase = true -- case sensitive search if input contains uppercase

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Highlight when yanking (copying) text -- from kickstart
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Terminal setup
local set = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0

		vim.bo.filetype = "terminal"
	end,
})

-- Set PowerShell as terminal
-- vim.opt.shell = '"C:/Program Files/PowerShell/7/pwsh.exe"'
-- vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", ",st", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)

-- netrw options
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "name"
vim.g.netrw_sizestyle = "H"

-- Show only WARN and ERROR diagnostics in R and Rmd
local function set_r_diagnostics()
	vim.diagnostic.config({
		virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
		signs = { severity = { min = vim.diagnostic.severity.WARN } },
		underline = { severity = { min = vim.diagnostic.severity.ERROR } },
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "r", "rmd" },
	callback = set_r_diagnostics,
})

vim.opt.undodir = "C:/.vim/.undodir"
vim.opt.undofile = true
