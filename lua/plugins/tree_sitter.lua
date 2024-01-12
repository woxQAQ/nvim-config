return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

--   main = 'nvim-treesitter.configs',
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            'c',
            'cpp',
            'go',
            'lua',
            'python',
            'vimdoc',
            'vim',
            'bash',
            'gomod',
            'gosum',
            'gowork',
            'luadoc',
            'yaml'
        },
        auto_tag = { enable = true },
        auto_installed = true,
        sync_install = false,
        highlight = {
            enable = true,
            -- disable = function (_, bufnr)
            --     return vim.b[bufnr].large_buf
            -- end,
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = true,
            -- disable = {"yaml"},
        },
        autopairs = {enable =true},
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<leader>gnn",
                node_incremental = "<leader>gnr",
                scope_incremental = "<leade>gne",
                node_decremental = "<leader>gnt"
            }
        },
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
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]k"] = { query = "@block.outer", desc = "Next block start" },
                    ["]f"] = { query = "@function.outer", desc = "Next function start" },
                    ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
                },
                goto_next_end = {
                    ["]K"] = { query = "@block.outer", desc = "Next block end" },
                    ["]F"] = { query = "@function.outer", desc = "Next function end" },
                    ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
                },
                goto_previous_start = {
                    ["[k"] = { query = "@block.outer", desc = "Previous block start" },
                    ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                    ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
                },
                goto_previous_end = {
                    ["[K"] = { query = "@block.outer", desc = "Previous block end" },
                    ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                    ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    [">K"] = { query = "@block.outer", desc = "Swap next block" },
                    [">F"] = { query = "@function.outer", desc = "Swap next function" },
                    [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
                },
                swap_previous = {
                    ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
                    ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
                    ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
                },
            },
        },
    }
}
