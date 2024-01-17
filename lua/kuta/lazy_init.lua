local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("kuta.lazy")
--require("lazy").setup(
--{
--
--    -- Fuzzy finder telescope
--    'nvim-telescope/telescope.nvim',
--    'nvim-lua/plenary.nvim',
--
--    -- Harpoon theprimeagem
--    {
--        "ThePrimeagen/harpoon",
--        branch = "harpoon2",
--        requires = { {"nvim-lua/plenary.nvim"} }
--    },
--
--
--    -- Color themes
--    {
--        "savq/melange-nvim",
--        name = "melange",
--        config = function()
--            vim.cmd.("colorscheme melange")
--        end
--    },
--
--    --Treesitter
--    {
--        'nvim-treesitter/nvim-treesitter',
--        build = ":TSUpdate"
--    },
--
--    --Mason
--
--    "williamboman/mason.nvim",
--    "williamboman/mason-lspconfig.nvim",


    --LSP Autocompletion
--    'mfussenegger/nvim-jdtls'
--
--
--    --LSP-Zero
--    use {
--        'VonHeikemen/lsp-zero.nvim',
--        branch = 'v3.x',
--        requires = {
--            -- LSP Support
--            {'neovim/nvim-lspconfig'},
--            -- Autocompletion
--            {'hrsh7th/nvim-cmp'},
--            {'hrsh7th/cmp-nvim-lsp'},
--            {'L3MON4D3/LuaSnip'},
--        }
--    }
--}, 
--{}
--)
