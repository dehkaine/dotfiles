return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lualine = require("lualine")
			-- load basic theme
			local theme = require("lualine.themes.gruvbox-material")
			-- customize theme colorscheme
			theme.normal.a.bg = "#718D83"
			theme.normal.b.bg = "#303436"
			theme.normal.b.fg = "#90a59d"
			theme.normal.c.bg = "#242728"
			theme.normal.c.fg = "#948a79"
			theme.insert.a.bg = "#8EC07C"
			theme.visual.a.bg = "#D3869B"
			-- setup
			lualine.setup({
				options = {
					theme = theme,
					icons_enabled = true,
					globalstatus = true,
					always_show_tabline = false,
					section_separators = { left = "", right = "" },
					component_separators = { left = ">", right = "<" },
					disabled_filetypes = {
					statusline = { "alpha", "dashboard" },
					winbar = {},
				},
				always_divide_middle = true,
				refresh = { statusline = 100, tabline = 100, winbar = 100 },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = { { "filename", path = 1 } },
				lualine_b = { "tabs" },
			},
			extensions = { "fzf", "quickfix", "man", "nvim-tree", "lazy", "toggleterm" },
			})
		end,
  },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enable = true,
				view = "cmdline_popup",
				opts =  {
					position = { row = "50%", col = "50%" },
					size = { width = "80%", height = "auto" },
				},
			},
			messages = {
				enbale = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},
			popupmenu =  {
				enable = true,
				backend = "nui",
			},
			presets =  {
				bottom_search = false,
				command_palette = false,
				long_message_to_split = false,
				inc_rename = false,
				lsp_doc_border = false,
			}
		},
		keys = {
			{
				"<leader>cmd", mode = "n", silent = true,
				function()
					if vim.g._noice_enabled == false then
						require("noice").cmd("enable")
						vim.g._noice_enabled = true
					else
						require("noice").cmd("disable")
						vim.g._noice_enabled = false
					end
				end,
			}
		},
	},
}
