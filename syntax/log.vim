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
syn keyword logTodo todo fixme note debug comment notice
syn keyword logError error bug caution dropped

"logComment: Lines that start with '#'
"以#号打头的行为注释文本
syn match   logComment '^#.*$' contains=logTodo

"reference from reply email, quotes, etc.
syn match   logReference '^[|>:]\(\s*[|>:]\)*'

"logCommand: Lines start with digit and '.'
"标题文本: 前面有任意个空格,数字.[数字.]打头, 并且该行里不含有,.。，等标点符号
syn match logCommand "^\(\d\+\.\)\+\s*[^,。，]\+$"
syn match logCommand '\(^>\)[^,。，]\+$' contains=logReference

"logCommand: Lines start with Chinese digit and '.'
"标题文本: 汉字数字加'.、'打头，且该行不含,.。，标点符号
syn match logCommand "^\([一二三四五六七八九十][、.]\)\+\s*[^,。，]\+$"

"logCommand: Lines start with digit
syn match logCommand "^[a-zA-Z0-9 ()-\/]\+>[^,。，]\+$"

"logList: Lines start with space and then '-+*.'
"列表文本: 任意空格打头, 后跟一个[-+*.]
syn match logList    '^\s*[-+*.] [^ ]'me=e-1

"logList: Lines start with space and then digit
"列表文本: 任意空格打头, 后跟一个(数字) 或 (字母) 打头的文本行
syn match logList    '^\s*(\=\([0-9]\+\|[a-zA-Z]\))'

"logList: Lines start with space and then digit and '.'
"列表文本: 至少一个空格打头, [数字.]打头, 但随后不能跟数字(排除把5.5这样的文
"本当成列表) 
syn match logList "^\s\+\d\+\.\d\@!"

"logApostrophe: text in the apostrophe
"单引号内文字
syn match   logApostrophe  '\'[^\']\+\''hs=s+1,he=e-1 contains=logUrl,logReference

"logQuotes: text in the quotoes
"双引号内文字, 包括全角半角, 作用范围最多两行
"syn match   logQuotes     '["“][^"”]\+\(\n\)\=[^"”]*["”]'hs=s+1,he=e-1 contains=logUrl,logReference

"logParentesis: text in the parentesis
"括号内文字, 不在行首(为了和logList区别), 作用范围最多两行
"syn match   logParentesis "[(（][^)）]\+\(\n\)\=[^)）]*[)）]" contains=logUrl,logReference

"logBrackets: text in the brackets
"其它括号内文字, 作用范围最多两行, 大括号无行数限制
syn match logBrackets     '<[^<]\+>'hs=s+1,he=e-1 contains=logUrl,logReference
syn match logBrackets     '\[[^\[]\+\(\n\)\=[^\[]*\]'hs=s+1,he=e-1 contains=logUrl,logReference
"syn region logBrackets    matchgroup=logOperator start="{"        end="}" contains=logUrl,logReference

"link url
syn match logUrl '\<[A-Za-z0-9_.-]\+@\([A-Za-z0-9_-]\+\.\)\+[A-Za-z]\{2,4}\>\(?[A-Za-z0-9%&=+.,@*_-]\+\)\='
syn match logUrl   '\<\(\(https\=\|ftp\|news\|telnet\|gopher\|wais\)://\([A-Za-z0-9._-]\+\(:[^ @]*\)\=@\)\=\|\(www[23]\=\.\|ftp\.\)\)[A-Za-z0-9%._/~:,=$@-]\+\>/*\(?[A-Za-z0-9/%&=+.,@*_-]\+\)\=\(#[A-Za-z0-9%._-]\+\)\='

"email text:
syn match logEmailMsg '^\s*\(From\|De\|Sent\|To\|Para\|Date\|Data\|Assunto\|Subject\):.*'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"类html文本
"syn match   logBold       '\*[^*[:blank:]].\{-}\*'hs=s+1,he=e-1
"syn match logItalic "^\s\+.\+$" "斜体文本

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color definitions (specific)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi logUrl        term=bold        cterm=bold  ctermfg=blue    gui=underline     guifg=blue
"hi logCommand     term=bold       cterm=bold      ctermfg=black   gui=bold        guifg=black
hi link logUrl      Underlined"ModeMsg"Tabline"PmenuSbar
hi link logCommand      Title"ModeMsg"Tabline"PmenuSbar
hi link logList         SignColumn"Pmenu"DiffText"Statement
hi link logComment      Special "Comment
hi link logReference    DiffAdd "Comment
hi link logQuotes       MoreMsg"String
hi link logApostrophe    MoreMsg"Special
hi link logParentesis   Special "Comment
hi link logBrackets  Special
hi link logError  ErrorMsg
hi link logTodo  Todo
hi link logEmailMsg     Structure

let b:current_syntax = 'log'
" vim:tw=0:et
