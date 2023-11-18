return {
    {
          'tpope/vim-fugitive',
          'tpope/vim-rhubarb',
          'tpope/vim-sleuth',
    },
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
            {   "<leader>qs",
                [[<cmd>lua require("persistence").load()<cr>]],
                desc = 'restore session for current directory'
            },
            {   "<leader>ql",
                [[<cmd>lua require("persistence").load({last = true})<cr>]],
                desc = 'restore the last session'
            },
            {   "<leader>qd",
                [[<cmd>lua require("persistence").stop()<cr>]],
                desc = 'stop save session when exit'
            },
        },
        config = true,
    },

    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        opts = {
            enable_check_bracket_line = false,
        },
        config = {
            check_ts = true,
        }
    },

    -- {
    --     "ethanholz/nvim-lastplace",
    --     config = true,
    -- },

    -- flash.nvim 用于快速跳转
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

    -- {
    --     "kamykn/spelunker.vim",
    --     event = "VeryLazy",
    --     config = function()
    --         vim.g.spelunker_check_type = 2
    --     end
    -- },

    {
        "ellisonleao/glow.nvim",
        event = "VeryLazy",
        config = true,
    },
    -- {
    --     "kevinhwang91/nvim-ufo",
    --     event = "InsertEnter",
    --     dependencies = "kevinhwang91/promise-async",
    --     opts = {
    --         preview = {
    --             mappings = {
    --                 scrollB = "<C-b>",
    --                 scrollF = "<C-f>",
    --                 scrollU = "<C-u>",
    --                 scrollD = "<C-d>",
    --             },
    --         },
    --         provider_selector = function (_, filetype, buftype)
    --             local function handleFallbackException(bufnr, err, providerName)
    --                 if type(err) == "string" and err:match "UfoFallbackException" then
    --                     return require("ufo").getFolds(bufnr, providerName)
    --                 else
    --                     return require("promise").reject(err)
    --                 end
    --             end
    --             return (filetype == "" or buftype == "nofile") and "indent" or function(bufnr)
    --             return require("ufo").getFolds(bufnr, "lsp"):catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end):catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
    --         end
    --     end,
    --     }
    -- },
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
                desc = "open the n[e]otree"
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
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function ()
            require('Comment').setup {
                padding = true,
                sticky = true,
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                opleader = {
                    line = "gc",
                    block = "gb"
                },
                extra = {
                    above = "gcO",
                    below = "gco",
                    eol = "gcA",
                },
                mappings = {
                    basic = true,
                    extra = true,
                },
            }
        end
    },
}
