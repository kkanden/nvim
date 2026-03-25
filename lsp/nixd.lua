local hostname = vim.system({ "hostname" }):wait().stdout
hostname = string.gsub(hostname, "\n", "")

return {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix" },
    settings = {
        nixd = {
            options = {
                nixos = {
                    expr = string.format(
                        "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.%s.options",
                        hostname
                    ),
                },
            },
        },
    },
}
