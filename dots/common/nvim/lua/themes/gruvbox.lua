return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "original"
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_italic = 1

			vim.cmd("colorscheme gruvbox-material")

			-- cursor color
			vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25,r-cr:hor20"
			vim.api.nvim_set_hl(0, "Cursor", { bg = "#ffcc00", fg = "#000000" })

			vim.api.nvim_set_hl(0, "Search",    { bg = "#D3869B", fg = "#000000" })
			vim.api.nvim_set_hl(0, "CurSearch", { bg = "#ffcc00", fg = "#000000" })

			-- lCursor color（insert mode）
			-- vim.api.nvim_set_hl()
		end,
	},
}
