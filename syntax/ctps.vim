"Script_name: log.vim
"Author: guoyoooping@163.com
"Date: 2010/02/19
"Release: 1.0.6
"Description: syntax for plain/text.
"Language: text/plain :)
"Location: $HOME/.vim/syntax or $VIMRUNTIME/syntax/
"Install_detail:
        "1. put this file in $HOME/.vim/syntax or $VIMRUNTIME/syntax/ 
        "2. Add the following line in your .vimrc:
        "syntax on "syntax highlighting on
        "let tlist_log_settings = 'log;c:content;f:figures;t:tables' "language definition for plain text
        "au BufRead,BufNewFile *.log setlocal ft=log "syntax highlight for log.vim 

syn case ignore "set case insensitive.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key words definition.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Keywords
syn keyword ctpsTodo todo fixme note debug comment notice
syn keyword logError error bug caution dropped
syn keyword ctpsKeyword WAIT SEND

syn match saveSentence 'SAVE [A-Za-z][A-Za-z0-9_]*'
syn match loadSentence 'LOAD [A-Za-z][A-Za-z0-9_]*'

"logComment: Lines that start with '#'
"以#号打头的行为注释文本
syn match   ctpsComment '^# .*$' contains=ctpsTodo

" color definitions (specific)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi logUrl        term=bold        cterm=bold  ctermfg=blue    gui=underline     guifg=blue
"hi logCommand     term=bold       cterm=bold      ctermfg=black   gui=bold        guifg=black

hi link ctpsComment     Comment
hi link saveSentence    Identifier
hi link loadSentence    Identifier
hi link ctpsKeyword MACRO
hi link ctpsTodo Todo

let b:current_syntax = 'ctps'
" vim:tw=0:et
