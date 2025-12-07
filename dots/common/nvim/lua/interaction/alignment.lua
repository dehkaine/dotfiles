return {
	{
		"echasnovski/mini.align",
		version = false,
		config = function ()
			local align = require("mini.align")
			align.setup({
				mappings = {
					start = "ga",
					start_with_preview = "gA",
				},
				steps = {
					pre_justify = { align.gen_step.filter("n == 1")},
				},
			})
		end
	},
}
