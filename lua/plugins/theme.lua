return {
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "folke/tokyonight.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lualine/lualine.nvim",
            "utilyre/barbecue.nvim",
            {
                "SmiteshP/nvim-navic",
                config = function ()
                    local icons = require 'misc.icons'
                    require ('nvim-navic').setup {
                        icons = icons.kind,
                        highlight = true,
                        lsp = {
                          auto_attach = true,
                        },
                        click = true,
                        separator = " " .. icons.ui.ChevronRight .. " ",
                        depth_limit = 0,
                        depth_limit_indicator = "..",
                    }
                end
            },
        },
        config = function()
            vim.cmd[[colorscheme tokyonight-storm]]
            require('lualine').setup(
            {
                options = {
                    theme = 'tokyonight',
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    ignore_focus = {"Neotree"}
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = { 'diff' },
                    lualine_x = { "diagnostics"},
                    lualine_y = { "filetype" },
                    lualine_z = { "progress" },
                },
                extensions = { "quickfix", "man", "fugitive" },
            })
            require('barbecue').setup
            {
                theme = 'tokyonight',
            }
            
        end

    },
}
