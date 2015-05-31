set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin($HOME.'/.vim/vundle')

" Plugin List
" OmniCppComplete
Plugin 'vim-scripts/OmniCppComplete'
" vim scirpts
Plugin 'vim-scripts/lookupfile'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/ShowMarks'
" status and tab line
Plugin 'bling/vim-airline'
" file list
Plugin 'scrooloose/nerdtree'
" auto complete
Plugin 'Shougo/neocomplete.vim'
" jump to files
Plugin 'kien/ctrlp.vim'
" ctags
Plugin 'majutsushi/tagbar'
" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'ivanov/vim-ipython'
Plugin 'scrooloose/syntastic'
Plugin 'hynek/vim-python-pep8-indent'
" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'marijnh/tern_for_vim'
Plugin 'burnettk/vim-angular'
" Coffee
Plugin 'vim-coffee-script'
Plugin 'lukaszkorecki/CoffeeTags'
" Golang
Plugin 'fatih/vim-go'
" XML
Plugin 'sukima/xmledit'
" ultisnips
source $HOME/.vim/vimrc_ultisnips.vim

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
