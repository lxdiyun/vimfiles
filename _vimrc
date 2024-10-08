"""""""""""""""""""""""""""""""""""""
" Default setting for vim, only for
" windows.
" Follow the _vimrc example
"""""""""""""""""""""""""""""""""""""
set nocompatible
"source $VIMRUNTIME/mswin.vim
set selection=exclusive
set selectmode=mouse,key
set mousemodel=popup
set keymodel=startsel,stopsel

let &termencoding=&encoding

" self setting
source $HOME/.vim/vimrc_local.vim

" set backup dir 
set backupdir=~/VimBackup
" set snippes file dir
:let g:snippets_dir="$HOME/.vim/snippets"
" vim 7.3 setting
if version >= 703
" set undo dir
   set undodir=$HOME/VimBackup
endif

" plug init
 source $HOME/.vim/vimrc_plug.vim

" tabline function
function MyTabLine()
	let s = ''
	let tabcolor = ''
	let tabnumcolor = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let tabcolor .= '%#TabLineSel#'
			let tabnumcolor = '%#TabLineIndexSel#'
		else
			let tabcolor .= '%#TabLine#'
			let tabnumcolor = '%#TabLineIndex#'
		endif

		let s .= tabcolor 

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" the label is made by MyTabLabel()
		let s .= tabnumcolor.(i+1).tabcolor.'[%{MyTabLabel(' . (i + 1) . ')}] '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999XX'
	endif

	return s
endfunction

" tablable funtion
function MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let filename = bufname(buflist[winnr - 1])
	let filename = fnamemodify(filename, ':p:t') 
	return filename
endfunction


" python bug fix
"py3 import os; sys.executable=os.path.join(sys.prefix, 'python.exe')
"set pythonthreehome=C:\\Users\\adli\\Anaconda3
"set pythonthreedll=C:\\Users\\adli\\Anaconda3\\python37.dll
