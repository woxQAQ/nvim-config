return {
    'mfussenegger/nvim-dap',
    event = "BufRead",
    -- NOTE: And you can specify dependencies as well
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        "theHamsta/nvim-dap-virtual-text",

        -- Add your own debuggers here
        'leoluz/nvim-dap-go',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        local virtual_text = require("nvim-dap-virtual-text")

        -- dap.adapters.lldb = {
        --     type = "executable",
        --     command = '/opt/homebrew/opt/'
        -- }

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,
            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
            'delve',
            },
        }
        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug: Start/[C]ontinue' })
        vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug: Step [I]nto' })
        vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug: Step [O]ver' })
        vim.keymap.set('n', '<leader>ds', dap.step_out, { desc = '[D]ebug: [S]tep Out' })
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle [b]reakpoint' })
        vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = '[D]ebug: Set [B]reakpoint' })
        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '  ',
                    play = '▶',
                    step_into = ' ⏎ ',
                    step_over = '  ',
                    step_out = '  ',
                    step_back = '  ',
                    run_last = ' ▶▶ ',
                    terminate = '  ',
                    disconnect = ' ⏏ ',
                },
            },

        }
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<leader>ds', dapui.toggle, { desc = '[D]ebug: [S]ee last session result.' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        virtual_text.setup()
        require('dap-go').setup()

    end
}

