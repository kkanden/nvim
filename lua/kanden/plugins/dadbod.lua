return {
    "kristijanhusak/vim-dadbod-ui",
    event = "VeryLazy",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" },
            lazy = true,
        },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
}
