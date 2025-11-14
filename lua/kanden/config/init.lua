require("kanden.config.remap")
require("kanden.config.set")
require("kanden.config.autocmd")
require("kanden.config.usercmd")
require("kanden.config.lazy")
require("kanden.config.lsp")
-- on NixOS treesitter parsers are installed through the home-manager module
-- which requires loading with `:packadd`
if vim.uv.os_uname().version:lower():match("nixos") then
    require("kanden.config.nvim-treesitter")
end

vim.cmd("colorscheme vague")
