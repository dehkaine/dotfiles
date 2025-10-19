return {
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = { default_mappings = true },
		config = function(_, opts)
			require("marks").setup(opts)
			 -- home row
			local seq = { 'a','s','d','f','g','h','j','k','l' }

			local function used_seq_marks_buf()
				local used, bufnr = {}, vim.api.nvim_get_current_buf()
				for _, it in ipairs(vim.fn.getmarklist(bufnr)) do
					local ch = it.mark:match("^'([a-z])$")
					if ch then used[ch] = true end
				end
				return used
			end

			local function buf_stack()
				if not vim.b.smartmarks_state then
					vim.b.smartmarks_state = { hist = {} }
				end
				return vim.b.smartmarks_state
			end

			local function set_next_seq_char()
				local used, pick = used_seq_marks_buf(), nil
				for _, ch in ipairs(seq) do
					if not used[ch] then pick = ch; break end
				end
				if not pick then vim.notify("No more marks", vim.log.levels.WARN) return end
				vim.cmd.normal({ args = { "m" .. pick }, bang = true })
				local S = buf_stack()
				for i = #S.hist, 1, -1 do
					if S.hist[i] == pick then table.remove(S.hist, i) end
				end
				table.insert(S.hist, pick)
			end

			local jump_prev_and_delete = "<Plug>(Marks-prev)<Plug>(Marks-deleteline)"

			-- 映射（覆盖默认的 + / - 行移动）
			local map = vim.keymap.set
			map("n", "<kPlus>",          set_next_seq_char,   { remap = true, desc = "SmartMarks: set next (home row)"})
			map("n", "<kMinus><kMinus>", jump_prev_and_delete,{ remap = true, desc = "SmartMarks: jump prev and delete"})
			map("n", "<kMinus>m",  "<Plug>(Marks-prev)",      { remap = true, desc = "SmartMarks: prev"})
			map("n", "<kMinus>M",  "<Plug>(Marks-next)",      { remap = true, desc = "SmartMarks: next"})
			map("n", "<kMinus>c",  "<Plug>(Marks-delete)",    { remap = true, desc = "SmartMarks: delete"})
			map("n", "<kMinus>,",  "<Plug>(Marks-deleteline)",{ remap = true, desc = "SmartMarks: deleteline"})
			map("n", "<kMinus>C",  "<Plug>(Marks-deletebuf)", { remap = true, desc = "SmartMarks: deleteBuf"})
		end,
	},
}
