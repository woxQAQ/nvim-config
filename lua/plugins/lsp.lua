return {
    "neovim/nvim-lspconfig",
    cmd = { "Mason", "Neoconf" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
        {
            "j-hui/fidget.nvim",
            opts = {}
        },
        "nvimdev/lspsaga.nvim",
    },
    config = function()
        local servers = {
            clangd = {},
            marksman = {},
            lua_ls = {
                Lua = {
                    format = {
                        enable = false,
                    },
                    diagnostics = {
                        globals = { 'vim'},
                    },
                    runtime = {
                        version = "LuaJIT",
                        special = {
                            spec = "require"
                        }
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.stdpath "config" .. "/lua"] = true,
                        }
                    },
                    telemetry = {enable = false}
                }
            },
            cssls = {},
            html = {},
            jsonls = {},
            yamlls = {},
            gopls = {},
        }
        local icons = require 'misc.icons'
        local default_diagnostic_config = {
            virtual_text = false,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = ""
            },
            signs = {
                active = true,
                values = {
                    {
                        name = "DiagnosticSignError",
                        text = icons.diagnostics.Error
                    },
                    {
                        name = "DiagnosticSignWarning",
                        text = icons.diagnostics.Warning
                    },
                    {
                        name = "DiagnosticSignHint",
                        text = icons.diagnostics.Hint
                    },
                    {
                        name = "DiagnosticSignInfo",
                        text = icons.diagnostics.Information
                    },
                }
            }
        }
        vim.diagnostic.config(default_diagnostic_config)
        for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
            vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = sign.name})
        end
        
        if vim.g.lsp_handlers_enabled then
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true })
            vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", silent = true })
        end
        require("neoconf").setup()
        require("neodev").setup()
        require("fidget").setup()
        require("lspconfig.ui.windows").default_options.order = "rounded"
        require("mason").setup()
        require("lspsaga").setup()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        settings = servers[server_name],
                        capabilities = capabilities,
                    }
                    if server_name == "lua_ls" then
                        require("neodev").setup{}
                    end
                end,
            }
        })
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                                {buffer = ev.buf, desc = {'[g]oto [D]eclaration'}})
                vim.keymap.set('n', 'gd', require "telescope.builtin".lsp_definitions,
                                {buffer = ev.buf, desc = {'[g]oto [d]efinition'}})
                vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                                {buffer = ev.buf, desc = '[K]Hover document'})
                vim.keymap.set('n', 'gi', require("telescope.builtin").lsp_implementations,
                                {buffer = ev.buf, desc = '[g]oto [i]mplement'})
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
                                {buffer = ev.buf, desc = '[control-k]signature document'})
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                                {buffer = ev.buf, desc = '[w]orkspace [a]dd Folder'})
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                                {buffer = ev.buf, desc = '[w]orkspave [r]emove Folder'})
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, {buffer = ev.buf, desc = '[w]orkspace [l]ist Folders'})
                vim.keymap.set('n', '<leader>da', vim.diagnostic.open_float,
                                {buffer = ev.buf, desc = 'Show [d]i[a]gnostics'})
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, 
                                {buffer = ev.buf, desc = 'type [D]efinition'})
                vim.keymap.set('n', '<leader>rn', "<cmd>Lspsaga rename ++project<CR>",
                                {buffer = ev.buf, desc = '[r]e[n]ame'})
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', "<cmd>Lspsaga code_action<CR>", 
                                {buffer = ev.buf, desc = '[c]ode [a]ction'})
                vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, 
                                {buffer = ev.buf, desc = '[g]oto [r]eference'})
                vim.keymap.set('n', '<leader>fm', function()
                    vim.lsp.buf.format { async = true }
                end, {buffer = ev.buf, desc = '[f]ormat current buffer'})
            end,
        })
    end
}
