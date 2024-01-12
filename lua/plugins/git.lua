return{
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        cmd =
        {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles"
        },
    },
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
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
}
