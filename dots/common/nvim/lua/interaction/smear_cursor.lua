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
}
