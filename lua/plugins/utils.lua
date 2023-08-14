return {
    {
        "rhysd/accelerated-jk",
        keys = {
            { "j", "<Plug>(accelerated_jk_gj)" },
            { "k", "<Plug>(accelerated_jk_gk)" },
        },
    },

    {
        "folke/persistence.nvim",
        keys = {
            { "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]] },
            { "<leader>ql", [[<cmd>lua require("persistence").load({last = true})<cr>]] },
            { "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]] },
        },
        config = true,
    },

    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        opts = {
            enable_check_bracket_line = false,
        },
    },

    {
        "ethanholz/nvim-lastplace",
        config = true,
    },

    {
        "folke/flash.nvim",
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = { "o" },
                function()
                    require("flash").remote()
                end,
                desc = "Flash remote",
            },
            {
                "R",
                mode = { "x", "o" },
                function()
                    require("flash").treesitter.search()
                end,
                desc = "Flash Treesitter.search",
            },
            {
                "c-s",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Flash toggle",
            },
        },
        config = true,
    },

    {
        "kamykn/spelunker.vim",
        event = "VeryLazy",
        config = function()
            vim.g.spelunker_check_type = 2
        end
    },

    {
        "ellisonleao/glow.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>e",
                mode = { "n", "v" },
                "<cmd>Neotree toggle<cr>",
                desc = "open the neotree"
            }
        },
        config = true,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        config = true,
    },

    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        config = true,
    },
}
