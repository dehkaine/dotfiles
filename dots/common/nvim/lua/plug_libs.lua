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

--
-- Setup Plugins
--
require("lazy").setup({
	spec =  {
		-- themes
		{ import = "themes.gruvbox" },
		{ import = "themes.statusline" },
		-- interaction
		{ import = "interaction.cursor" },
		{ import = "interaction.jump" },
		{ import = "interaction.marks" },
		-- plugins
		{ import = "plugins.git" },
		{ import = "plugins.coc" },
		{ import = "plugins.fzf" },
		-- render
		{ import = "render.markdown" },
	},
	-- defaults = { lazy = true },
	-- { "theniceboy/nvim-deus" },
})

vim.o.lazyredraw = false

-- vim.cmd("colorscheme deus")
-- vim.api.nvim_set_hl(0, "lCursor",  { fg = "#ebbc4e", bg = "#ffcc00" })


