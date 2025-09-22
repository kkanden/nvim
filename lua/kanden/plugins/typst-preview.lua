local is_nixos = vim.uv.os_uname().version:match("NixOS")
local tinymist = is_nixos and "/run/current-system/sw/bin/tinymist"
local websocat = is_nixos and "/run/current-system/sw/bin/websocat"

return {
    "chomosuke/typst-preview.nvim",
    event = "VeryLazy",
    opts = {
        debug = true,
        dependencies_bin = {
            tinymist = tinymist,
            websocat = websocat,
        },
    },
}
