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
                    ensure_installed = {
                        "tsserver",
                        "gradle_ls",
                        "bashls",
                        "cssls",
                        "jdtls",
                        "jedi_language_server",
                        "jsonls",
                        "kotlin_language_server",
                        "lua_ls",
                    },
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
        lspconfig.lua_ls.setup({
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
    end,
}
