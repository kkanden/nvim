return {
    cmd = { "nixd" },
    filetypes = { "nix" },
    root_markers = { "flake.nix" },
    settings = {
        nixd = {
            options = {
                nixos = {
                    expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.nixos.options",
                },
                ["home-manager"] = {
                    expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.nixos.options.home-manager.users.type.getSubOptions []",
                },
            },
        },
    },
}
