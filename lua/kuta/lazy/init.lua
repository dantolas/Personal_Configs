return{
    {
        --Plenary
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },
    
    
    {

        --FuGITive
        "tpope/vim-fugitive",
        config = function()

            vim.keymap.set("n","<C-g>",vim.cmd.Git)
        end
    },


    -- Undotree
    {

        'mbbill/undotree',
        config = function()

            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
}
