-- These servers will be installed, 
-- and then setup with the default lspconfig.setup
local lsp_servers = {
    "tsserver",
    "gradle_ls",
    "bashls",
    "cssls",
    "jdtls",
    "jedi_language_server",
    "jsonls",
    "lua_ls",
}
return {
    "neovim/nvim-lspconfig",
    dependencies = {

        --Snippets (don't even know what those are lmao)
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        --Mason
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = lsp_servers,
                })
            end,
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local on_attach = function(client, bufnr) end
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities()
        )
        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        -- ALL SERVERS ARE SETUP HERE
        for i,server in pairs(lsp_servers) do

            --Skip jdtls setup
            if(server == "jdtls") then
                goto continue
            end

            --Specifically setup lua_ls
            if(server == "lua_ls") then

                lspconfig[server].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                })
                goto continue
            end
            lspconfig[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            ::continue::
        end

    end,
}
