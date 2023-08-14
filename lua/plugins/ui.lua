return {
    {
        "akinsho/bufferline.nvim",
        config = true,
        event = "VeryLazy",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = true,
        event = "VeryLazy",
    },

    {
        "lewis6991/gitsigns.nvim",
        config = true,
        event = "VeryLazy",
    },

    {
        "goolord/alpha-nvim",
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end,
    },

    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure()
        end,
        event = "VeryLazy",
    },
}
