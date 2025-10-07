return {
	{
		"neoclide/coc.nvim",
		branch = "release",
		-- need nodejs
		build = "npm ci",
		-- lazy load
		event = { "BufReadPre", "BufNewFile" },

		init = function()
			vim.g.coc_global_extensions = {
				"coc-rust-analyzer",
				"coc-json",
				"coc-toml",
				"coc-yaml",
				"coc-lua",
				"coc-explorer",
			}
		end,

		config = function()
			local map = vim.keymap.set
			local opts = { silent = true, noremap = false }
			local cmplOpts = { silent = true, noremap = true, expr = true }
		-- 
		-- ==========  Key Mappings  ==========
		-- 
			map("n", "gd", "<Plug>(coc-definition)",  opts)
			map("n", "gr", "<Plug>(coc-references)",  opts)
			map("n", "gy", "<Plug>(coc-type-definition)", opts)
			map("n", "gi", "<Plug>(coc-implementation)",  opts)
			map("n", "<leader>rn", "<Plug>(coc-rename)",  opts)
			map({ "n", "x" }, "<leader>ca", "<Plug>(coc-codeaction)", opts)

			-- document 
			map({ "n", "x" }, "<leader>f", "<Plug>(coc-format-selected)", opts)
			--  map("n", "<leader>F", "<Cmd>CocCommand editor.action.formatDocument<CR>", { silent = true })

			-- Diagnostic
			map("n", "[g", "<Plug>(coc-diagnostic-prev)", opts)
			map("n", "]g", "<Plug>(coc-diagnostic-next)", opts)

			-- Hover Function
			map("n", "K", function()
			if vim.fn.CocActionAsync("doHover") == 0 then
				vim.cmd("lua vim.lsp.buf.hover()")
			end
			end, { silent = true })

			-- Completion
			-- map("i", "<Up>",    [[coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"]],      cmplOpts)
			-- map("i", "<Down>",  [[coc#pum#visible() ? coc#pum#next(1) : "\<Down>"]],    cmplOpts)
			-- map("i", "<Left>", [[coc#pum#visible() ? coc#pum#cancel() : "\<Left>"]],   cmplOpts)
			map("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], cmplOpts)

			--
			-- ==========  Highlighting & Signature  ==========
			--
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			callback = function()
				pcall(vim.fn.CocActionAsync, "highlight")
			end,
			})
			-- save signature
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			--   callback = function() vim.fn.CocAction("format") end,
			-- })
			vim.opt.completeopt = { "menuone", "noselect" }
		end,
	},
	-- coc-explorer
	{
		"weirongxu/coc-explorer",
		dependencies = { "neoclide/coc.nvim" },
		keys = {
			{
				"<leader>e",
				function()
					vim.cmd("CocCommand explorer --position floating --floating-position center")
				end,
				desc = "coc-explorer (floating center)"
			},
		},
	}
}
