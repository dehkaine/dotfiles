-- Install lazy.nvim if not exists
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

-- Enable true color support before loading colorscheme
vim.opt.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

--
-- Setup Plugins
--
require("lazy").setup({
	-- { "theniceboy/nvim-deus" },
	{ "sainnhe/gruvbox-material" },
	-- { "sphamba/smear-cursor.nvim",
	-- 	config = function()
	-- 		require("smear_cursor").setup({
	-- 			smear_between_buffers = true,
	-- 			smear_between_neighbor_lines = true,
	-- 			smear_insert_mode = true,
	-- 			--cursor_color = "#1D2021",
	-- 			--stiffness = 0.2,
	-- 			stiffness = 0.6,
	-- 			mass = 0.01,
	-- 			length = 2,
	-- 			--trailing_stiffness = 0.2,
	-- 			matrix_pixel_threshold = 0.9,
	-- 			velocity_cutoff = 0.01,
	-- 		})
	-- 	end,
	-- },
})

-- vim.cmd("colorscheme deus")
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "original"
vim.cmd("colorscheme gruvbox-material")

-- vim.api.nvim_set_hl(0, "lCursor",  { fg = "#ebbc4e", bg = "#ffcc00" })
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25,r-cr:hor20"
vim.api.nvim_set_hl(0, "Cursor", { bg = "#ffcc00", fg = "#000000" })

