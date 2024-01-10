local icons = require("misc.icons")
return{
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
}
