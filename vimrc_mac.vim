" tags
set tags+=~/tags/tags,~/tags/nginx.tags
" clang_complete setting
" for Objective C
let xcode_platform_path = '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform'
let ios_sdk_path = xcode_platform_path . '/Developer/SDKs/iPhoneSimulator5.1.sdk'
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
