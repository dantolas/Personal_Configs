function ColorTheme(color)
	color = color or "melange"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0,"Normal",{bg="none"})
	vim.api.nvim_set_hl(0,"NormalFloat",{bg="none"})
end
return{
    {
        "savq/melange-nvim",
        name = "melange",
        config = function()
            vim.cmd("colorscheme melange")
            ColorTheme()
        end
    },
}
