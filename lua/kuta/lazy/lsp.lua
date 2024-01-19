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
                        'kotlin_language_server',
                        'lua_ls'
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
                        ["jdtls"] = function()
                        end
                    }
                })
            end
        },
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

