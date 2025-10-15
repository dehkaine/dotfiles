local function i_map( key, cmdline )
	local prefix = ","
	local cmd = prefix..key
	vim.keymap.set( "i", cmd, cmdline, { buffer = true, noremap = true, silent = true} )
end

-- function
i_map( "F", "function()<CR><++><CR>end<CR><++><Esc>3k$i" )

-- if..end
i_map( "if", "if then<CR><++><CR>end<CR><++><Esc>3k$Ffa " )
i_map( "i1", "if then <++> end<Esc>Ffa " )

i_map( "<l", "< leader><Esc>Flhxf>a" )

-- jump to <++> placeholder
i_map( "f", [[<Esc>/<++><CR>:nohlsearch<CR>"_c4l]] )
i_map( "a", [[<Esc>/ <++><CR>:nohlsearch<CR>"_c5l]] )
