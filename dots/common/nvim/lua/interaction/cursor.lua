return {
	{
		"sphamba/smear-cursor.nvim",
		config = function()
			require("smear_cursor").setup({
				smear_between_buffers = true,
				smear_between_neighbor_lines = true,
				smear_insert_mode = true,
				stiffness = 0.6,
				mass = 0.01,
				length = 2,
				matrix_pixel_threshold = 0.9,
				velocity_cutoff = 0.01,
			})
		end,
	},
	{
		"declancm/cinnamon.nvim",
		opts = {
			keymaps = { basic = true, extra = true },
			options = {
				mode = "cursor",
				delay = 4,
				step_size = { vertical = 1, horizontal = 2 },
				max_delta = { line = false, colum = false, time = 1000 }
			}
		}
	},
	{
		"jake-stewart/multicursor.nvim",
		 event = "VeryLazy",
		 branch = "1.0",
		 config = function()
			 local mc = require("multicursor-nvim")
			 mc.setup()
			 local map = vim.keymap.set

			 -- Simple Add/Del Cursor
			 map({"n", "v"}, "<leader>m", mc.toggleCursor)

			 -- Enable/Disable Multi-Cursor
			 map({"n", "v"}, "<Esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Normal Esc
				end
			end)

			map({"n", "v"}, "<leader>am", function() mc.lineAddCursor(1) end)
			map({"n", "v"}, "<leader>aM", function() mc.lineAddCursor(-1) end)
			map({"n", "v"}, "<leader>sm", function() mc.lineSkipCursor(1) end)
			map({"n", "v"}, "<leader>sM", function() mc.lineSkipCursor(-1) end)

			map({"n", "v"}, "<leader>nm", function() mc.matchAddCursor(1) end)
			map({"n", "v"}, "<leader>nM", function() mc.matchAddCursor(-1) end)
		end
	}
}
