function CR()
	if search('\\item', 'b', line('.')) && !pumvisible()
		return "\r\\item "
	endif
	return "\r"
endfunction
inoremap <expr><buffer> <CR> CR()
