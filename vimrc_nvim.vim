" Plugin Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" GUI setting
if filereadable($HOME."/_gvimrc_neo_win")
	autocmd UIEnter * source $HOME/_gvimrc_neo_win
endif

" neovim autoread fix
autocmd FocusGained * silent! checktime
