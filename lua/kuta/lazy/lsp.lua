return{
    "neovim/nvim-lspconfig",
    dependencies = {

        --Snippets (don't even know what those are lmao)
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        --Mason
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        'tsserver',
                        'gradle_ls',
                        'bashls',
                        'cssls',
                        'jdtls',
                        'jedi_language_server',
                        'jsonls',
                        'kotlin_language_server'
                    },
                    handlers = {
                        function(server_name)
                            require("lspconfig")[server_name].setup{}
                        end,
                        ["lua_ls"] = function ()
                            local lspconfig = require("lspconfig")
                            lspconfig.lua_ls.setup {
                                settings = {
                                    Lua = {
                                        diagnostics = {
                                            globals = { "vim" }
                                        }
                                    }
                                }
                            }
                        end,
                    }
                })
            end
        },
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        {
            'hrsh7th/nvim-cmp',
            config = function()

                local cmp = require'cmp'
                local cmp_select = {behavior = cmp.SelectBehavior.Select}

                cmp.setup({
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        end,
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'vsnip' }, -- For vsnip users.
                        { name = 'luasnip' }, -- For luasnip users.
                    }, {
                        { name = 'buffer' },
                    })
                })
            end

        }
},
config = function()
vim.diagnostic.config{
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    }
}
end
}

