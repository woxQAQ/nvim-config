return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
            region_check_events = "CursorMoved",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies =
        {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "roobert/tailwindcss-colorizer-cmp.nvim",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
        },
        event = "InsertEnter",
        opts = function()
            local cmp = require 'cmp'
            local border_opts = {
                border = 'rounded',
                winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
            }
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            local luasnip = require 'luasnip'

            local icons = require "misc.icons"
            return {
                enabled = vim.g.cmp_enabled,
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false
                },
                preselect = cmp.PreselectMode.None,
                view = {
                    entries = {
                        name = 'custom',
                        selection_order = "top_down",
                    },
                    docs = {
                        auto_open = false,
                    }
                },
                duplicates = {
                    nvim_lsp = 1,
                    luasnip = 1,
                    cmp_tabnine = 1,
                    buffer = 1,
                    path = 1,
                },
                formatting = {
                    field = { "kind", "abbr", "menu" },
                    format = function (entry, vim_item)
                        vim_item.kind = icons.kind[vim_item.kind]
                        vim_item.menu = ({
                            nvim_lsp = "",
                            nvim_lua = "",
                            luasnip = "",
                            buffer = "",
                            path = "",
                            emoji = "",
                        })[entry.source.name]
                        if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
                            local duplicates = {
                                buffer = 1,
                                path = 1,
                                nvim_lsp = 0,
                                luasnip = 1,
                            }
                            local duplicates_default = 0
                            vim_item.dup = duplicates[entry.source.name] or duplicates_default
                        end
                        if vim.tbl_contains( {"nvim_lsp"}, entry.source.name) then
                            local words = {}
                            for word in string.gmatch(vim_item.word, "[^-]+") do
                                table.insert(words, word)
                            end
                            local color_name, color_number
                            if
                                words[2] == 'x'
                                or words[2] == "y"
                                or words[2] == "t"
                                or words[2] == "b"
                                or words[2] == "l"
                                or words[2] == "r"
                            then
                                color_name = words[3]
                                color_number = words[4]
                            else
                                color_number = words[3]
                                color_name = words[2]
                            end

                            if color_name == "white" or color_name == "black" then
                                local color
                                if color_name == "white" then
                                  color = "ffffff"
                                else
                                  color = "000000"
                                end
                                local hl_group = "lsp_documentColor_mf_" .. color
                                vim.api.nvim_set_hl(0, hl_group, {fg = '#' .. color, bg = '#' .. color})
                                vim_item.kind_hl_group = hl_group
                                vim_item.kind = string.rep(" ", 2)
                                return vim_item
                            end
                            if not color_name or not color_number then
                                return vim_item
                            end
                            local color_index = tonumber(color_number)
                            local tailwindcss_colors = require 'tailwindcss-colorizer-cmp'.Tailwindcss
                            if not tailwindcss_colors[color_number] then
                                return vim_item
                            end
                            if not tailwindcss_colors[color_number][color_index] then
                                return vim_item
                            end
                            local color = tailwindcss_colors[color_number][color_index]
                            local hl_group = "lsp_documentColor_mf_" .. color
                            vim.api.nvim_set_hl(0, hl_group, {fg = '#' .. color, bg = '#' .. color})
                            vim_item.kind_hl_group = hl_group
                            vim_item.kind = string.rep(" ", 2)
                        end
                        return vim_item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-space>'] = cmp.mapping.complete {},
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources {
                    {
                        name = "nvim_lsp",
                        priority = 1000,
                        entry_filter = function (entry, ctx)
                            local kind = require 'cmp.types.lsp'.CompletionItemKind[entry:get_kind()]
                            if kind == 'Snippet' and ctx.prev_context.filetype == 'java' then
                                return false
                            end
                            if ctx.prev_context.filetype == 'markdown' then
                                return true
                            end
                            if kind == 'Text' then
                                return false
                            end
                            return true
                        end
                    },
                    { name = "luasnip", priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                },
            }
        end
    },
}
