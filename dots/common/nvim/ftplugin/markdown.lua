-- Set RenderMarkdown Text Color
vim.api.nvim_set_hl(0, "RenderMarkdownText", { fg = "#83A598", bg = "#1D2021"})
vim.opt_local.winhighlight:append(
	{
		Normal = "RenderMarkdownText",
		NormalNC = "RenderMarkdownText",
	}
)

-- RenderMarkdown Toggle
vim.keymap.set("n", "<localleader>mr", "<cmd>RenderMarkdown toggle<CR>", { buffer = true, desc = "render-markdown: Toggle"} )
vim.keymap.set("n", "<localleader>mR", "<cmd>RenderMarkdown restart<CR>", { buffer = true, desc = "render-markdown: Restart"} )

-- local bufnr = vim.api.nvim_get_current_buf()
-- Markdown Snippets
-- require("ft.markdown.snippets").setup(bufnr)
-- require("ft.markdown.set_element").setup(bufnr)
require("ft.markdown.snippets")
require("ft.markdown.set_element")

