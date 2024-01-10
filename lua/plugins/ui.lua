local icons = require("misc.icons")

return {
    {
        "akinsho/bufferline.nvim",
        config = true,
        event = "VeryLazy",
    },

    -- 缩进
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            icons = require 'misc.icons'
            require("ibl").setup{
                indent = {
                    char = icons.ui.LineMiddle,
                },
                scope = {
                    show_start = false,
                    show_end = false,
                }
            }
        end,

        event = "VeryLazy",
    },

    -- vim-illuminate 用来高亮同名函数
    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                providers = {
                    'lsp',
                    'treesitter',
                },
                delay = 100,
           })
        end,
        event = "VeryLazy",
    },

    -- {
    --     "onsails/lspkind.nvim",
    --     opts = {
    --         mode = "symbol",
    --         symbol_map = {
    --             Array = "󰅪",
    --             Boolean = "⊨",
    --             Class = "󰌗",
    --             Constructor = "",
    --             Key = "󰌆",
    --             Namespace = "󰅪",
    --             Null = "NULL",
    --             Number = "#",
    --             Object = "󰀚",
    --             Package = "󰏗",
    --             Property = "",
    --             Reference = "",
    --             Snippet = "",
    --             String = "󰀬",
    --             TypeParameter = "󰊄",
    --             Unit = "",
    --         },
    --         menu = {}
    --     },
    --     enabled = vim.g.icons_enabled,
    --     config = function ()
    --         require("lspkind")
    --     end
    -- },
    {
        "folke/trouble.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        keys = {
            {
                "<leader>xx",
                function ()
                    require("trouble").toggle()
                end,
                desc = "open trouble"
            },
            {
                "<leader>xw",
                function ()
                    require("trouble").toggle("workspace_diagnostics")
                end,
                desc = "open workspace diagnostics"
            },
            {
                "<leader>xq",
                function ()
                    require("trouble").toggle("quickfix")
                end,
                desc = "open quickfix"
            },
            {
                "<leader>xl",
                function ()
                    require("trouble").toggle("loclist")
                end,
                desc = "open quickfix"
            },
            {
                "gR",
                function ()
                    require("trouble").toggle("lsp_reference")
                end,
                desc = "open quickfix"
            },
        }
    },
}
