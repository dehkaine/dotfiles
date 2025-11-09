local map = vim.api.nvim_buf_set_keymap

map(0, "n", "<localleader>e", "<cmd>lua require('snacks').explorer.open()<CR>", {noremap = true, silent = true})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gdscript",
	callback = function()
		require("snacks").explorer.open()
		-- vim.cmd("wincmd l")
		vim.defer_fn(function ()
			vim.cmd("wincmd l")
		end, 100)
	end,
})

-- 仅 gdscript 缓冲设置：把语义组链接到 treesitter/主题里相近的组
-- vim.api.nvim_set_hl(0, "CocSem_property", { link = "@property" })
-- vim.api.nvim_set_hl(0, "CocSem_method",   { link = "@function" })
-- vim.api.nvim_set_hl(0, "CocSem_class",    { link = "@type" })

-- 如果主题没有对应 @property/@function，也可以直接给色值（示例配 gruvbox）：
-- vim.api.nvim_set_hl(0, "CocSem_property", { fg = "#fabd2f" })
-- vim.api.nvim_set_hl(0, "CocSem_method",   { fg = "#b8bb26" })
-- vim.api.nvim_set_hl(0, "CocSem_class",    { fg = "#83a598", bold = true })
