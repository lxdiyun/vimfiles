
" It's based on:
runtime colors/darkblue.vim
runtime colors/default.vim

let g:colors_name = "Black"

hi Normal guibg=black guifg=GhostWhite ctermbg=black
hi NonText guibg=black ctermbg=233

" More faded is too similar to blue on LCDs.
" hi Identifier guifg=#90CC90
hi Identifier           guifg=lightgreen ctermfg=lightgreen
hi Constant             ctermfg=darkred guifg=#ff9494 
hi underlined           cterm=underline term=underline guifg=#00d8ff ctermfg=darkcyan
hi PreProc              ctermfg=darkred guifg=red gui=none cterm=none
hi Comment              guifg=#47a2ff ctermfg=darkblue cterm=none
hi Special              ctermfg=darkred  guifg=#ebb262 
hi Cursor               guibg=red guifg=white ctermfg=white ctermbg=darkred 
hi Statement            guifg=#e3e544 ctermfg=3 cterm=none
hi StatusLine           gui=reverse term=reverse cterm=reverse
hi LineNr               guifg=#71ff71 ctermfg=darkgreen
hi Search               guifg=black ctermfg=black
hi CursorLine           cterm=none ctermbg=238 guibg=Grey40
hi CursorColumn         ctermbg=238 guibg=Grey40
hi Title                ctermfg=lightblue guifg=lightgreen gui=none cterm=none
hi Directory            guifg=#47a2ff ctermfg=lightblue cterm=none
hi Type                 gui=none guifg=green ctermfg=darkgreen
hi Pmenu                ctermbg=238 ctermfg=white guibg=Grey40 guifg=GhostWhite
hi PmenuSel             guifg=black cterm=bold gui=bold ctermfg=black
hi Visual               ctermbg=238 guibg=grey50
hi Ignore               guifg=grey40 
hi ColorColumn          guibg=darkgreen ctermbg=darkgreen
hi Keyword              ctermfg=darkred cterm=bold guifg=red gui=bold
hi TabLine              ctermfg=darkyellow cterm=none
hi TabLineSel           ctermfg=LightYellow cterm=bold
hi SpellBad             ctermbg=red ctermfg=white term=reverse
hi ShowMarksHLo         ctermfg=white
hi ShowMarksHLm         ctermfg=white
hi DiffAdd              ctermfg=black guifg=black ctermbg=LightYellow guibg=LightYellow
hi DiffChange           ctermfg=black guifg=black ctermbg=LightYellow guibg=LightYellow
hi DiffDelete           ctermfg=black guifg=black ctermbg=LightCyan guibg=LightCyan
hi DiffText             guifg=red guibg=LightYellow gui=bold ctermbg=LightYellow ctermfg=darkred cterm=bold
hi Folded               ctermfg=black ctermbg=lightgrey
hi PmenuSel             ctermbg=LightRed ctermfg=black cterm=none guibg=black guifg=white gui=none
hi Pmenu                ctermbg=lightgrey ctermfg=black cterm=none guibg=grey guifg=white gui=none

" For showmarks plug-in
hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black

" For multi highlight words plug-in mark
highlight def MarkWord1  ctermbg=LightCyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black
highlight def MarkWord2  ctermbg=LightGreen    ctermfg=Black  guibg=#A4E57E    guifg=Black
highlight def MarkWord3  ctermbg=LightYellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
highlight def MarkWord4  ctermbg=LightRed      ctermfg=Black  guibg=#FF7272    guifg=Black
highlight def MarkWord5  ctermbg=LightMagenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
highlight def MarkWord6  ctermbg=LightBlue     ctermfg=Black  guibg=#9999FF    guifg=Black


