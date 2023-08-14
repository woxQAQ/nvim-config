return{
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    main = 'nvim-treesitter.configs',
    build = ":TSUpdate",
    opts = {
        eusure_installed = "all",
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                include_surrounding_whitespace = false,
                lockahead = true,

                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = { query = "@class.inner",
                        desc = "Select inner part of a class region" },
                    ["as"] = { query = "@scope", query_group = "locals",
                        desc = "Select language scope" },
                },
            },
        },
    }
}
