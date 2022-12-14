call plug#begin('~/.vim/plugged')

" Plugin List
" OmniCppComplete
Plug 'vim-scripts/OmniCppComplete'
" vim scirpts
Plug 'vim-scripts/lookupfile'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/ShowMarks'
" status and tab line
Plug 'bling/vim-airline'
" file list
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" auto complete
"Plug 'Shougo/neocomplete.vim'
" jump to files
Plug 'kien/ctrlp.vim'
" ctags
Plug 'majutsushi/tagbar'
" Python
"Plug 'davidhalter/jedi-vim'
"Plug 'ivanov/vim-ipython'
Plug 'scrooloose/syntastic'
Plug 'hynek/vim-python-pep8-indent'
" Javascript
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'marijnh/tern_for_vim'
Plug 'burnettk/vim-angular'
"Plug 'dsawardekar/ember'
"Plug 'dsawardekar/portkey'
" Coffee
"Plug 'vim-coffee-script'
"Plug 'lukaszkorecki/CoffeeTags'
" Golang
Plug 'fatih/vim-go'
" XML
Plug 'sukima/xmledit'
if has('nvim')
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

	" ultisnips
	source $HOME/.vim/vimrc_ultisnips.vim

endif

" Add plugins to &runtimepath
call plug#end()
