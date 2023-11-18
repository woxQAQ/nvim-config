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

    {
        "lewis6991/gitsigns.nvim",
        config = true,
        event = "VeryLazy",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = {
                    hl = "GitSignsAdd",
                    numhl = "GitSignsAddNr",
                    linehl = "GitSignsAddLn",
                    -- text = '+'
                },
                change = {
                    hl = "GitSignsChange",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                    -- text = '~'
                },
                delete = {
                    hl = "GitSignsDelete",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                    -- text = '_'
                },
                topdelete = {
                    hl = "GitSignsDelete",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                    -- text = '‾',
                },
                changedelete = {
                    hl = "GitSignsDelete",
                    numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn",
                    -- text = '~',
                }
            },
            worktrees = vim.g.git_worktrees,
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp',
                               require('gitsigns').preview_hunk,
                               {buffer = bufnr, desc = 'Preview git hunk'})

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({'n', 'v'}, ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr = true, buffer = bufnr, desc = 'Jump to next hunk'})
                vim.keymap.set({'n', 'v'}, '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {
                    expr = true,
                    buffer = bufnr,
                    desc = 'Jump to previous hunk'
                })
            end,
            preview_config = {
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        }
    },

    -- alpha-nvim 是 nvim 的开启界面
    {
        "goolord/alpha-nvim",
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
            local dashboard = require 'alpha.themes.dashboard'
            local function button(sc, txt, keybind, keybind_opts)
                local b = dashboard.button(sc, txt, keybind, keybind_opts)
                b.opts.hl_shortcut = "Marco"
                return b
            end
            dashboard.section.header.val = {
                [[                       _             _     _           ]],
                [[__      _______  __   / \   _ __ ___| |__ (_)_   _____ ]],
                [[\ \ /\ / / _ \ \/ /  / _ \ | '__/ __| '_ \| \ \ / / _ \]],
                [[ \ V  V / (_) >  <  / ___ \| | | (__| | | | |\ V /  __/]],
                [[  \_/\_/ \___/_/\_\/_/   \_\_|  \___|_| |_|_| \_/ \___|]]
            }
            dashboard.section.buttons.val = {
                button("f", icons.ui.Files .. " Find file", ":Telescope find_files <CR>"),
                button("n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
                -- button("s", icons.ui.SignIn .. " Load session", ":lua require('persistence').load()<CR>"),
                button("p", icons.git.Repo .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
                button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
                button("t", icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
                button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
                button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
            }
            dashboard.section.header.opts.hl = "String"
            dashboard.section.buttons.opts.hl = "Marco"
            require 'alpha'.setup(dashboard.opts)
        end,
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
    -- }
}
