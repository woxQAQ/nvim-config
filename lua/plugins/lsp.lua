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
            tag = "legacy",
        },
        "nvimdev/lspsaga.nvim",
    },
    config = function()
        local servers = {
            clangd = {},
            marksman = {},
            lua_ls = {
                Lua = {
                    workspace = {checkThirdParty = false},
                    telemetry = {enable = false}
                }
            },
            gopls = {},
        }
        require("neoconf").setup()
        require("neodev").setup()
        require("fidget").setup()
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
                vim.keymap.set('n', '<leader>da', require "telescope.builtin".diagnostics,
                                {buffer = ev.buf, desc = 'Show [d]i[a]gnostics'})
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, 
                                {buffer = ev.buf, desc = 'type [D]efinition'})
                vim.keymap.set('n', '<leader>rn', "<cmd>Lspsaga rename ++project<CR>",
                                {buffer = ev.buf, desc = '[r]e[n]ame'})
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', "<cmd>Lspsaga code_action<CR>", 
                                {buffer = ev.buf, desc = '[c]ode [a]ction'})
                vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, 
                                {buffer = ev.buf, desc = '[g]oto [r]eference'})
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, {buffer = ev.buf, desc = '[f]ormat current buffer'})
            end,
        })
    end
}
