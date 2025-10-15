return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "mdx", "rmd" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			preset = "none",
			-- file_types = { "markdown" },
			heading = {
				icons = { "", "", "", "", "", "" },
				signs = { "" },
				position = "inline",
				border = false,
				border_virtual = true,
				left_pad = 0,
				render_modes = true,
				backgrounds = { "NONE","NONE","NONE","NONE","NONE","NONE", },
			},
			code = {
				width = "block",
				highlight_inline = "RenderMarkdownCodeInfo",
				-- border
				border = "thin",
				-- border = false,
				left_pad = 1,
				right_pad = 1,
				-- language
				language_icon = true,
				language_name = true,
				position = "right",
			},
			bullet = {
				icons = { "●", "○", "◆", "◇" }
			},
			checkbox = {
				enabled = true,
				bullet = false,
				unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
				checked   = { icon = "󰄵 ", highlight = "RenderMarkdownChecked"  },
			},
			quote = {
				icon = "▍",
				highlight = "RenderMarkdownQuote6",
			},
			dash  = { icon = "─", width = "full" },
			pipe_table = {
				alignment_indicator = '─',
				border = { '╭', '┬', '╮', '├', '┼', '┤', '╰', '┴', '╯', '│', '─' },
			},
			anti_conceal = {
				enabled = true,
				ignore = {
					code_background = true,
					indent = true,
					sign = true,
					virtual_lines = true
				},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)

			local set = vim.api.nvim_set_hl
			local ok, _ = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })

			-- sign icon color
			-- set(0, "RenderMarkdownH1", { fg = "#ebdbb2", bold = true })

			set(0, "RenderMarkdownQuote6", { fg = "#D3869B", bold = true })
			set(0, "RenderMarkdownBullet", { fg = "#948A79" })
			set(0, "RenderMarkdownUnchecked", { fg = "#FB4934" })
			set(0, "RenderMarkdownChecked", { fg = "#8EC07C" })

			set(0, "RenderMarkdownCode", { fg = "#8EC07C", bg = "#161819" })
			set(0, "RenderMarkdownCodeInfo", { fg = "#8EC07C", bg = "#161819" })
			set(0, "RenderMarkdownCodeInline", { fg = "#ffffff", bg = "#303436" })
			set(0, "RenderMarkdownCodeBorder", { fg = "#D3869B", bg = "#161819" })
		end,
		keys = {
			-- { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "render-markdown: Toggle" },
			-- { "<leader>mR", "<cmd>RenderMarkdown restart<CR>", desc = "render-markdown: Restart" },
		},
	},
}
