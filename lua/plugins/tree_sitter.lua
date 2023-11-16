return{
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

--   main = 'nvim-treesitter.configs',
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            'c', 'cpp', 'go', 'lua', 'python', 'vimdoc', 'vim', 'bash'
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        -- incremental_selection = {
        --     enable = true,
        --     keymaps = {
        --         init_selection = '<leader>z',
        --         node_incremental = '<c-space>',
        --         scope_incremental = '<c-s>',
        --         node_decremental = '<M-space>'
        --     }
        -- },
        textobjects = {
            select = {
                enable = true,
                include_surrounding_whitespace = false,
                lockahead = true,

                keymaps = {
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
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
