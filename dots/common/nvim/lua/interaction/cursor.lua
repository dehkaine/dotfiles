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
	}
}
