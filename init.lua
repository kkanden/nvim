vim.g.on_nixos = vim.uv.os_uname().version:lower():match("nixos")
require("kanden")
