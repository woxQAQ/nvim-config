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
            lua_ls = {},
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
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', require "telescope.builtin".lsp_definitions, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', require("telescope.builtin").lsp_implementations, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<leader>da', require "telescope.builtin".diagnostics, opts)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>rn', "<cmd>Lspsaga rename ++project<CR>", opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', "<cmd>Lspsaga code_action<CR>", opts)
                vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, opts)
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end,
        })
    end
}
