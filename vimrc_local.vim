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
	set colorcolumn=80,120
endif

" nocompatiable mode active
set nocompatible
" load example setting
source $VIMRUNTIME/vimrc_example.vim
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
set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %-a%=[%l,%03c-%03v]\ \ [%L]\ \ [%3.5P]\ \ [%05.8OH:%2BH]
"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F12>
" show a menu when using tab complementation under command mode
set wildmenu
" Required to be able to use keypad keys and map missed escape sequences
set esckeys
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
" set tab label line
set tabline=%!MyTabLine()
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

" Init snipMate
fun ADInitSnipMate()
	let b:snipMateOn = 0
	call ResetSnippets()
	call ADUpdateSnipFile(0)
endfun

" update or reset snipMate file
let b:snipMateOn = 0
fun ADUpdateSnipFile(echoMsg)
	if 0 == b:snipMateOn
		let g:snippets_dir = "~/.vim/snippets,~/.vim/bundle/snipMate/snippets"
		call GetSnippets(g:snippets_dir, &filetype)
		if 1 == a:echoMsg
			echo "SnipMate On"         
		endif
		let b:snipMateOn = 1
	else
		call ResetSnippets()
		if 1 == a:echoMsg
			echo "SnipMate Off"         
		endif
		let b:snipMateOn = 0 
	endif
endfun

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

	let commentPattern = '^\ *#'
	let addCommand = 's/^/#/'
	let removeCommand = 's/#//'

	for ft in split(&filetype, '\.')
		if ft == 'vim'
			let commentPattern = '^\ *\"'
			let addCommand = 's#^#"#'
			let removeCommand = 's#"##'
			break
		elseif ft =~ '\<objc\>\|\<cpp\>\|\<cs\>\|\<c\>'
			let commentPattern = '^\ *\/\/'
			let addCommand = 's#^#//#'
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
command! -nargs=0 -bar SnipMate call ADUpdateSnipFile(1)

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

"""""""""""""""""""""""""""""""""""""
" Self-auto-command definition
"""""""""""""""""""""""""""""""""""""
autocmd  BufEnter * nested  call ADInitSnipMate()

"""""""""""""""""""""""""""""""""""""
" Self-defining hot key binding
"""""""""""""""""""""""""""""""""""""
" nerd tree
nmap -0 :NERDTreeToggle<CR>

" taglist mapping 
nnoremap -= :Tlist<CR> 

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

" enable django syntax
nnoremap -5 :setfiletype htmldjango<cr>

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
"let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
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

"""""""""""""""""""""""""""""""""""""
" jedi-vim setting
let g:jedi#popup_select_first = 0

"""""""""""""""""""""""""""""""""""""
"  neocomplcache setting
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
"let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags noci

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
