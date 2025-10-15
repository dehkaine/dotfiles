local function i_map( key, cmdline )
	local prefix = "\\"
	local cmd = prefix..key
	vim.keymap.set( "i", cmd, cmdline, { buffer = true, noremap = true, silent = true} )
end

-- append "," to last
i_map( ",", "<Esc>A,<Esc>" )
-- i_map( ",", "<Esc>A,<Esc>" )

-- jump to <++> placeholder
-- i_map( "f", [[<Esc>/<++><CR>:nohlsearch<CR>"_c4l]] )
