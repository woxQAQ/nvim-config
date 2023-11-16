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
            require("ibl").setup{}
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
                add = {text = '+'},
                change = {text = '~'},
                delete = {text = '_'},
                topdelete = {text = '‾'},
                changedelete = {text = '~'}
            },
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
            end
        }
    },

    -- alpha-nvim 是 nvim 的开启界面
    {
        "goolord/alpha-nvim",
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
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
}
