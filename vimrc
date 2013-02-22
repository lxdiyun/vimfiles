" self setting
source $HOME/.vim/vimrc_local.vim

if filereadable($HOME."/.vimrc_mac.vim")
	source $HOME/.vimrc_mac.vim 
endif

" set backup dir 
set backupdir=~/VimBackup
" set snippes file dir
:let g:snippets_dir="~/.vim/snippets"
" vim 7.3 setting
if version >= 703
	set undodir=~/VimBackup
endif

