"""""""""""""""""""""""""""""""""""""
" pathogen plugin manager
"""""""""""""""""""""""""""""""""""""
call pathogen#infect()

"""""""""""""""""""""""""""""""""""""
" personal Vim setting
"""""""""""""""""""""""""""""""""""""
" vim 7.3 setting
" disable undofile 
if version >= 703
	"disable undofile 
	set noundofile
	" set color column - column label
	set colorcolumn=120,160
endif

"textwidth for wrap
set textwidth=120
" nocompatiable mode active
set nocompatible
" load example setting
"source $HOME/.vim/vimrc_example.vim
" behave selection
"behave mswin
" set file encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936
" set encoding
set encoding=utf-8
" set no wrap up
set nowrap
" set side scroll speed
set sidescroll=1
" show line number on left
set number
" set auto indent
set autoindent
" use English and UTF-8, can't use under windows
"lan en_US.UTF-8
" set default compile, use for /make
"compiler ant
" set color scheme
colorscheme Black
" set backup dir 
set backup
" set fold method
"set foldmethod=syntax
" set fold column
"set fdc=5
"set fold level
set foldlevel=999
" set ignore case
set ignorecase
" set the Doxygen highlight to be default highlight
let g:load_doxygen_syntax=1
" set shiftwidth
set shiftwidth=8
" set tab width
set tabstop=8
" no expand tab to space
set noexpandtab
" set c indebt option
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,t0,is,+s,c3,C0,/0,(0,us,U0,w0,W1s,m0,j0,)20,*30,#0
" set backspace key
set backspace=indent,eol,start
" show cursor column
set nocursorcolumn 
" show cursor line
set nocursorline
" always show status line
set laststatus=2
" set statusline
"set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %-a%=[%l,%03c-%03v]\ \ [%L]\ \ [%3.5P]\ \ [%05.8OH:%2BH]
"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F12>
" show a menu when using tab complementation under command mode
set wildmenu
" Required to be able to use keypad keys and map missed escape sequences
"set esckeys
" Complete longest common string, then each full match enable this for bash compatible behaviour
set wildmode=longest,full
" enable syntax
syntax enable
" enable filetype plugin and indent
filetype plugin indent on
" start taglist on the right side
:let Tlist_Use_Right_Window = 1
" set list char
set listchars=tab:>-
" show list
set list
" auto show table line
set showtabline=1
" set mouse active mode
set mouse=nv
" set format option (auto add comment * when type o)
set formatoptions=otcq
" Complete options (disable preview scratch window)
set completeopt=menu,longest
" Limit popup menu height
set pumheight=15
" set autoc change dir
set autochdir
if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

"""""""""""""""""""""""""""""""""""""
" Self_defining function
"""""""""""""""""""""""""""""""""""""
" svn diff funtion
function FlwSvnDiffToggle()
	if bufexists( "__SVN_DIFF__" )
		bwipeout __SVN_DIFF__
	else
		if exists("t:flwsvndiff")
			diffoff!
			let l:fileName = t:flwsvndiff
			unlet t:flwsvndiff
			exec "bwipeout " . l:fileName           
		else
			let t:flwsvndiff = expand("%:h") . "/.svn/text-base/" . expand("%:t") . ".svn-base"
			let l:ft = &ft
			exec "silent vert diffsplit " . t:flwsvndiff
			set readonly
			set buftype=nofile
			exec "set ft=" . l:ft
			wincmd p
			autocmd VimResized * :wincmd =
		endif
	endif
endfunction

" helper function to toggle hex mode
function ToggleHex()
	" hex mode should be considered a read-only operation
	" save values for modified and read-only for restoration later,
	" and clear the read-only flag for now
	let l:modified=&mod
	let l:oldreadonly=&readonly
	let &readonly=0
	let l:oldmodifiable=&modifiable
	let &modifiable=1
	if !exists("b:editHex") || !b:editHex
		" save old options
		let b:oldft=&ft
		let b:oldbin=&bin
		" set new options
		setlocal binary " make sure it overrides any textwidth, etc.
		let &ft="xxd"
		" set status
		let b:editHex=1
		" switch to hex editor
		%!xxd
	else
		" restore old options
		let &ft=b:oldft
		if !b:oldbin
			setlocal nobinary
		endif
		" set status
		let b:editHex=0
		" return to normal editing
		%!xxd -r
	endif
	" restore values for modified and read only state
	let &mod=l:modified
	let &readonly=l:oldreadonly
	let &modifiable=l:oldmodifiable
endfunction

" Clear control character
function ADClearControlCharavter()
	:execute '%s///g'
	"   :execute '%s///g'
	"   :execute '%s///g'
	"   :execute '%s///g'
	"   :execute '%s///g'
endfunction

" format text function
fun ADIndent()
	let oldLine=line('.')

	execute "set comments=s0:/*,mb:*,ex:*/"
	normal(gg=G)
	execute ':' . oldLine
endfun 

" get select lines or current line
fun s:GetCurrentLine(currentMode)
	let startLine = 0
	let endLine = 0

	if 's' == a:currentMode || 'v' == a:currentMode
		let startLine = line("'<")
		let endLine = line("'>")
	else
		let startLine = line(".")
		let endLine = startLine
	endif

	return startLine.','.endLine
endfun

" add or remove comment function
fun AddOrRemoveComment(currentMode)
	let currentLines = s:GetCurrentLine(a:currentMode)
	let selectBufString = getbufline('%', currentLines)
	let selectIsComment = 1

	let commentPattern = '^[\ \t]*#'
	let addCommand = 's/^\([\ \t]*\)/\1#/'
	let removeCommand = 's/#//'

	for ft in split(&filetype, '\.')
		if ft == 'vim'
			let commentPattern = '^[\ \t]*\"'
			let addCommand = 's#^#"#'
			let removeCommand = 's#"##'
			break
		elseif ft == 'autohotkey'
			let commentPattern = '^[\ \t]*\;'
			let addCommand = 's#^#;#'
			let removeCommand = 's#;##'
			break
		elseif ft =~ '\<objc\>\|\<cpp\>\|\<cs\>\|\<c\>\|\<java.*\>\|\<go\>'
			let commentPattern = '^[\ \t]*\/\/'
			let addCommand = 's#^\([\ \t]*\)#\1//#'
			let removeCommand = 's#//##'
		endif
	endfor


	for line in  selectBufString
		if line !~ commentPattern
			let selectIsComment = 0
			break
		endif
	endfor

	if 1 == selectIsComment
		:execute currentLines.removeCommand
	else
		:execute currentLines.addCommand
	endif
endfun

" add indent
fun AddIndent(currentMode)
	let currentLines = s:GetCurrentLine(a:currentMode)

	:execute currentLines.'>'
endfun

" remove indent
fun RemoveIndent(currentMode)
	let currentLines = s:GetCurrentLine(a:currentMode)

	:execute currentLines.'<'
endfun

" command line
function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

" self defined search function
function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("vimgrep " . '/'. l:pattern . '/g' . ' %')
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""
" Self-command definition
"""""""""""""""""""""""""""""""""""""
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

"""""""""""""""""""""""""""""""""""""
" Self-auto-command definition
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" Self-defining hot key binding
"""""""""""""""""""""""""""""""""""""
" taglist/tagbar mapping 
nnoremap -= :Tagbar<CR> 

" nerd tree
nmap -0 :NERDTreeToggle<CR>


" omnicppcomplete generate tag file by hot key
" map <C-F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" vimgrep setting
nmap -9 :vimgrep /<c-r>=expand("<cword>")<cr>/g %
vnoremap -9 :call VisualSearch('gv')<CR>

" svn diff 
nmap -8 :call FlwSvnDiffToggle()<CR>
nmap g-8 :new __SVN_DIFF__ <CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg

" Hex mode
nnoremap -7 :Hexmode<CR>

" snip mate
nnoremap -6 :SnipMate<cr> 

" enable neocomplete
nnoremap -5 :NeoCompleteToggle<cr>

" 1~4 reserved for filetype

" smart paste from clipboard
imap <C-Insert>  <C-O>:set paste<CR><C-r>*<C-O>:set nopaste<CR>

"<F5> is for plugin lookup file
"

" clear control character
nmap <F4>  :<C-U>call ADClearControlCharavter()<cr>

" destruct code's indent
map <F3>   :call ADIndent()<cr>

" tab all buffer 
nmap <C-Tab>   :tab sall<cr>

" comment or uncomment code
nmap <C-C>   :<C-U>call AddOrRemoveComment('n')<cr>
vmap <C-C>  :<C-U>call AddOrRemoveComment('v')<cr>
smap <C-C>  <esc>:call AddOrRemoveComment('s')<cr>

" page up/down
map <C-J>   18j
map <C-K>   18k

" select just pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" add indent
"map  >   :<C-U>call AddIndent('n')<cr>
"vmap >   :<C-U>call AddIndent('v')<cr>
"smap >   <esc>:call AddIndent('s')<cr>
" remove indent
"map  <   :<C-U>call RemoveIndent('n')<cr>
"vmap <   :<C-U>call RemoveIndent('v')<cr>
"smap <   <esc>:call RemoveIndent('s')<cr>
"""""""""""""""""""""""""""""""""""""
" Self-defining type
"""""""""""""""""""""""""""""""""""""
" TxtBrowser setting
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
au BufRead,BufNewFile *.txt setlocal ft=txt
let tlist_tst_settings = 'tst;t:TESTCASE;f:figures'
au BufRead,BufNewFile *.tst setlocal ft=tst
let tlist_tips_settings = 'tips;t:TIPS;f:figures'
au BufRead,BufNewFile *.tips setlocal ft=tips
let tlist_log_settings = 'log;c:COMMAND'
au BufRead,BufNewFile *.log setlocal ft=log
au BufRead,BufNewFile *.logs setlocal ft=log
let tlist_ctps_settings = 'ctps;c:COMMENT'
au BufRead,BufNewFile *.ctps setlocal ft=ctps
" object-c setting
let tlist_objc_settings = "ObjectiveC;
\i:class interface;
\I:class implementation;
\P:Protocol;
\m:Object method;
\c:Class method;
\v:Global variable;
\F:Object field;
\f:A function;
\p:A property;
\t:A type alias;
\s:A type structure;
\e:An enumeration;
\M:A preprocessor macro"
"""""""""""""""""""""""""""""""""""""
" Taglist Setting
"""""""""""""""""""""""""""""""""""""
" show Taglist menu
let Tlist_Show_Menu=1
" flod other file that mention
let Tlist_File_Fold_Auto_Close=1
" close when only Taglist window left
let Tlist_Exit_OnlyWindow=1

"""""""""""""""""""""""""""""""""""""
" Taglist and cscope project setting
" Use to locate the tag file
"""""""""""""""""""""""""""""""""""""
" add tags

" add cscsope file

"""""""""""""""""""""""""""""""""""""
" Python Setting
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" Plugin Setting
"""""""""""""""""""""""""""""""""""""
"showmarks setting
" Enable ShowMarks
let g:showmarks_enable = 1
" Show which marks
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
"let g:showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let g:showmarks_hlline_lower=1
let g:showmarks_hlline_upper=1

"""""""""""""""""""""""""""""""""""""
" Nerd Tree setting
let g:NERDTreeDirArrows=0

"""""""""""""""""""""""""""""""""""""
" Lookup File setting
let g:LookupFile_DefaultCmd = ':LUWalk'


"""""""""""""""""""""""""""""""""""""
" vim-ipython setting
let g:ipy_completefunc = 'local'

"""""""""""""""""""""""""""""""""""""
" CtrlP setting
let g:ctrlp_cmd = 'CtrlPMixed'

""""""""""""""""""""""""""""""""""""""""""""""
" syntastic setting
let g:syntastic_always_populate_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

""""""""""""""""""""""""""""""""""""""""""""""
" jedi-vim setting
let g:jedi#show_call_signatures = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 0
let g:jedi#auto_vim_configuration = 0
autocmd  FileType python let b:did_ftplugin = 1

""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete setting
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 0

""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
let g:tagbar_width = 32

"javascript-libraries-syntax
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 0
autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1

let g:used_javascript_libs = 'underscore,angularjs,angularui'

""""""""""""""""""""""""""""""""""""""""""""""
" go.vim
let g:go_disable_autoinstall = 1
let g:go_gotags_bin = 'gotags'

""""""""""""""""""""""""""""""""""""""""""""""
" statusline airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'

"neovim
if has("nvim")
	source $HOME/.vim/vimrc_nvim.vim
endif
