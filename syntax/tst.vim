"Script_name: tst.vim
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
        "let tlist_tst_settings = 'tst;c:content;f:figures;t:tables' "language definition for plain text
        "au BufRead,BufNewFile *.tst setlocal ft=tst "syntax highlight for tst.vim 

syn case ignore "set case insensitive.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key words definition.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Keywords
syn keyword tstTodo todo fixme note debug comment notice
syn keyword tstError error bug caution dropped

"TEST SETUP, Steps, Result
syn match tstSetup "TEST SETUP -.*$"
syn match tstSteps "TEST STEPS -.*$"
syn match tstResult "EXPECTED RESULTS -.*$"

"Test Case Title
syn match tstTitle "^TC-[0-9]\+.\+$"
syn match tstTitle "^ENDTC-[0-9]\+.\+$"


"tstComment: Lines that start with '#'
"以#号打头的行为注释文本
syn match   tstComment '^#.*$' contains=tstTodo

"tstTitle: Lines start with digit and '.'
"标题文本: 前面有任意个空格,数字.[数字.]打头, 并且该行里不含有,.。，等标点符号
"syn match tstTitle "^\(\d\+\.\)\+\s*[^,。，]\+$"

"tstTitle: Lines start with Chinese digit and '.'
"标题文本: 汉字数字加'.、'打头，且该行不含,.。，标点符号
syn match tstTitle "^\([一二三四五六七八九十][、.]\)\+\s*[^,。，]\+$"

"tstTitle: Lines start with digit
"标题文本: 以数字打头, 中间有空格, 后跟任意文字. 且该行不含有,.。，标点符号
"syn match tstTitle "^\d\s\+.\+\s*[^,。，]$"

"tstList: Lines start with space and then '-+*.'
"列表文本: 任意空格打头, 后跟一个[-+*.]
syn match tstList    '^\s*[-+*.] [^ ]'me=e-1

"tstList: Lines start with space and then digit
"列表文本: 任意空格打头, 后跟一个(数字) 或 (字母) 打头的文本行
"syn match tstList    '^\s*(\=\([0-9]\+\|[a-zA-Z]\))'

"tstList: Lines start with space and then digit and '.'
"列表文本: 至少一个空格打头, [数字.]打头, 但随后不能跟数字(排除把5.5这样的文
"本当成列表) 
"syn match tstList "^\s\+\d\+\.\d\@!"

"tstApostrophe: text in the apostrophe
"单引号内文字
syn match   tstApostrophe  '\'[^\']\+\''hs=s+1,he=e-1 contains=tstUrl,tstReference

"tstQuotes: text in the quotoes
"双引号内文字, 包括全角半角, 作用范围最多两行
"syn match   tstQuotes     '["“][^"”]\+\(\n\)\=[^"”]*["”]'hs=s+1,he=e-1 contains=tstUrl,tstReference

"tstParentesis: text in the parentesis
"括号内文字, 不在行首(为了和tstList区别), 作用范围最多两行
"syn match   tstParentesis "[(（][^)）]\+\(\n\)\=[^)）]*[)）]" contains=tstUrl,tstReference

"tstBrackets: text in the brackets
"其它括号内文字, 作用范围最多两行, 大括号无行数限制
syn match tstBrackets     '<[^<]\+\(\n\)\=[^<]*>'hs=s+1,he=e-1 contains=tstUrl,tstReference
syn match tstBrackets     '\[[^\[]\+\(\n\)\=[^\[]*\]'hs=s+1,he=e-1 contains=tstUrl,tstReference
"syn region tstBrackets    matchgroup=tstOperator start="{"        end="}" contains=tstUrl,tstReference

"link url
syn match tstUrl '\<[A-Za-z0-9_.-]\+@\([A-Za-z0-9_-]\+\.\)\+[A-Za-z]\{2,4}\>\(?[A-Za-z0-9%&=+.,@*_-]\+\)\='
syn match tstUrl   '\<\(\(https\=\|ftp\|news\|telnet\|gopher\|wais\)://\([A-Za-z0-9._-]\+\(:[^ @]*\)\=@\)\=\|\(www[23]\=\.\|ftp\.\)\)[A-Za-z0-9%._/~:,=$@-]\+\>/*\(?[A-Za-z0-9/%&=+.,@*_-]\+\)\=\(#[A-Za-z0-9%._-]\+\)\='

"email text:
syn match tstEmailMsg '^\s*\(From\|De\|Sent\|To\|Para\|Date\|Data\|Assunto\|Subject\):.*'
"reference from reply email, quotes, etc.
syn match   tstReference '^[|>:]\(\s*[|>:]\)*'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"类html文本
"syn match   tstBold       '\*[^*[:blank:]].\{-}\*'hs=s+1,he=e-1
"syn match tstItalic "^\s\+.\+$" "斜体文本

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color definitions (specific)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"hi tstUrl        term=bold        cterm=bold  ctermfg=blue    gui=underline     guifg=blue
"hi tstTitle     term=bold       cterm=bold      ctermfg=black   gui=bold        guifg=black
hi link tstUrl      Underlined"ModeMsg"Tabline"PmenuSbar
hi link tstTitle      Title"ModeMsg"Tabline"PmenuSbar
hi link tstList         SignColumn"Pmenu"DiffText"Statement
hi link tstComment      Special "Comment
hi link tstReference    DiffAdd "Comment
hi link tstQuotes       MoreMsg"String
hi link tstApostrophe    MoreMsg"Special
hi link tstParentesis   Special "Comment
hi link tstBrackets  Special
hi link tstError  ErrorMsg
hi link tstTodo  Todo
hi link tstEmailMsg     Structure
hi link tstSetup  PreProc
hi link tstSteps  PreProc
hi link tstResult PreProc

let b:current_syntax = 'tst'
" vim:tw=0:et
