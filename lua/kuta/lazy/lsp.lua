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
    "html",
    "volar"
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
        for _,server in pairs(lsp_servers) do

            if(server == "volar") then
                lspconfig[server].setup{
                    filetypes = {'vue','typescript','javascript'}
                }
            end

            --Skip jdtls setup
            if(server == "jdtls") then
                goto continue
            end

            --Specifically setup lua_ls
            if(server == "lua_ls") then

                lspconfig[server].setup({
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
                capabilities = capabilities,
            })

            ::continue::
        end

        -- Solve some LSP conflicts
        local lsp_conficts, _ = pcall(vim.api.nvim_get_autocmds, { group = "LspAttach_conflicts" })
        if not lsp_conficts then
            vim.api.nvim_create_augroup("LspAttach_conflicts", {})
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            group = "LspAttach_conflicts",
            desc = "prevent tsserver and volar competing",
            callback = function(args)
                if not (args.data and args.data.client_id) then
                    return
                end
                local active_clients = vim.lsp.get_active_clients()
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                -- prevent tsserver and volar competing
                if client.name == "volar" then
                    for _, client_ in pairs(active_clients) do
                        -- stop tsserver if volar is already active
                        if client_.name == "tsserver" then
                            client_.stop()
                        end
                    end
                elseif client.name == "tsserver" then
                    for _, client_ in pairs(active_clients) do
                        -- prevent tsserver from starting if volar is already active
                        if client_.name == "volar" then
                            client.stop()
                        end
                    end
                end
            end,
        })

   end,
}
