"""""""""""""""""""""""""""""""""""""
" Default setting for vim, only for
" windows.
" Follow the _vimrc example
"""""""""""""""""""""""""""""""""""""
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

let &termencoding=&encoding

" self setting
source $VIM/vimfiles/vimrc_local.vim

" set backup dir 
set backupdir=D:\VimBackup
" set snippes file dir
:let g:snippets_dir="$VIM/vimfiles/snippets"
" vim 7.3 setting
if version >= 703
" set undo dir
   set undodir=~/VimBackup
endif

