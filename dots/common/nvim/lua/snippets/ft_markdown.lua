local function i_map( key, cmdline )
	local prefix = ","
	local cmd = prefix..key
	vim.keymap.set( "i", cmd, cmdline, { buffer = true, noremap = true } )
	-- vim.keymap.set( "i", "/"..key, cmdline, { buffer = true, noremap = true } )
end

-- heading
i_map( "1", "# <CR><++><Esc>kA" )
i_map( "2", "## <CR><++><Esc>kA" )
i_map( "3", "### <CR><++><Esc>kA" )
i_map( "4", "#### <CR><++><Esc>kA" )
i_map( "5", "##### <CR><++><Esc>kA" )
i_map( "6", "###### <CR><++><Esc>kA" )

-- bold
i_map( "b", "**** <++><Esc>F*hi" )
-- code block
i_map( "c", "``` <CR><++><CR>```<CR><CR><++><Esc>4kA")
-- inline code
i_map( "i", "`` <++><Esc>F`i" )
-- link
i_map( "l", "[](<++>) <++><Esc>F[a" )
-- picture
i_map( "p", "![](<++>) <++><Esc>F[a" )
-- splitline
i_map( "s", "---\n" )
-- strikethrough
i_map( "S", "~~~~ <++><Esc>F~hi")
-- check box
i_map( "t", "- [ ] " )

-- jump to <++> placeholder
i_map( "f", [[<Esc>/<++><CR>:nohlsearch<CR>"_c4l]] )
i_map( "a", [[<Esc>/ <++><CR>:nohlsearch<CR>"_c5l]] )
