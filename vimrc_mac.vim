" tags
set tags+=~/tags/tags,~/tags/nginx.tags
" clang_complete setting
" for Objective C
let xcode_platform_path = '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform'
let ios_sdk_path = xcode_platform_path . '/Developer/SDKs/iPhoneSimulator7.1.sdk'
" clangコマンドの最後に追加されるオプション
let options_for_ios = [
\ '-isysroot', ios_sdk_path,
\ '-fblocks',
\ '-fexceptions',
\ '-D__IPHONE_OS_VERSION_MIN_REQUIRED=40300',
\ '-F' . ios_sdk_path . '/System/Library/Frameworks',
\ '-include', 'Foundation/Foundation.h',
\ '-include', 'UIKit/UIKit.h'
\]

let g:clang_exec = '/usr/bin/clang'
let g:clang_user_options = ''
for o in options_for_ios
	let g:clang_user_options .= ' '.shellescape(o)
endfor

" pythonで落ちる threadの取り回しが甘いんだろうなぁ
let g:clang_use_library = 0
let g:clang_library_path = '/Developer/usr/clang-ide/lib'

let g:clang_complete_auto = 1
let g:clang_complete_copen = 0
let g:clang_periodic_quickfix = 0
let g:clang_complete_macros = 1
let g:clang_complete_patterns = 0

if g:clang_use_library
else
	let g:clang_user_options .= ' 2>/dev/null || exit 0'
endif

let g:clang_debug = 0

"" BEGIN copied from http://www.daskrachen.com/2011/12/how-to-make-tagbar-work-with-objective.html
" add a definition for Objective-C to tagbar
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds' : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro' : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface' : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol' : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration' : 'e'
    \ }
\ }
"" END copied from http://www.daskrachen.com/2011/12/how-to-make-tagbar-work-with-objective.html

" plug init
 source $HOME/.vim/vimrc_plug.vim

set luadll=/usr/local/opt/lua/lib/liblua5.3.dylib
