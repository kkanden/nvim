return {
    "echasnovski/mini.icons",
    opts = {},
    config = function(opts)
        require("mini.icons").setup(opts)
        MiniIcons.mock_nvim_web_devicons()
    end,
}
