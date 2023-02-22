"""""""""""""""""""""""""""""""""""""
" personal GVIM setting
"""""""""""""""""""""""""""""""""""""
"set GUI font
set guifont=Fixed\ 11
set guifontwide=WenQuanYi\ Bitmap\ Song\ 10
" set tab label style under GUI mode
set guitablabel=%N\ %t
" use Black colorscheme
colorscheme Black
" set window size
set lines=45 columns=180
" maximize the window
"au GUIEnter * simalt ~x
" taglist menu 
nmenu &Taglist.&Open/Close\ Taglist<TAB><F8>  :Tlist <CR>
nmenu &Taglist.&Update\ Taglist<TAB><F5>  :call PtUpdateTag() <CR>
" set mouse mode to all
set mouse=a

"""""""""""""""""""""""""""""""""""""
" Self-defining hot key binding
"""""""""""""""""""""""""""""""""""""
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
"vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

"SHIFT-Insert are Paste                                                                                                                               
map <S-Insert>          "+gP
cmap <S-Insert>         <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" " Visual mode without the +virtualedit feature.  They are pasted as if they
" " were characterwise instead.
" " Uses the paste.vim autoload script.

exe 'inoremap <script> <S-Insert>' paste#paste_cmd['i']
exe 'vnoremap <script> <S-Insert>' paste#paste_cmd['v']

"""""""""""""""""""""""""""""""""""""
" Self-command definition
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" Self_defining function
"""""""""""""""""""""""""""""""""""""

