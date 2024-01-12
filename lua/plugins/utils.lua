return {
    {
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
        config = function ()
            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "single",
                enable_git_status = true,
                enable_modified_markers = true,
                enable_diagnostics = true,
                sort_case_insensitive = true,
                default_component_configs = {
                    indent = {
                        with_markers = true,
                        with_expanders = true,
                    },
                modified = {
                    symbol = " ",
                    highlight = "NeoTreeModified",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "",
                    folder_empty_open = "",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "",
                        deleted = "",
                        modified = "",
                        renamed = "",
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                position = "float",
                width = 35,
            },
            filesystem = {
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
            },
            event_handlers = {
                {
                  event = "neo_tree_window_after_open",
                  handler = function(args)
                    if args.position == "left" or args.position == "right" then
                      vim.cmd("wincmd =")
                    end
                  end,
                },
                {
                  event = "neo_tree_window_after_close",
                  handler = function(args)
                    if args.position == "left" or args.position == "right" then
                      vim.cmd("wincmd =")
                    end
                  end,
                },
            },
        })
    end,
    },

    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        config = true,
    },
}
