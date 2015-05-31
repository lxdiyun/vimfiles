unlet b:current_syntax
syn include @HTML $VIMRUNTIME/syntax/html.vim
syn region htmlTemplate start=+<script [^>]*type *=[^>]*text/ng-template[^>]*>+ keepend end=+</script>+me=s-1 contains=@HTML,htmlScriptTag,@htmlPreproc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mustache and handlebar
" enable django syntax
syn region mustacheScriptTemplate start=+<script [^>]*type *=[^>]*text/\(mustache\|x-handlebars\)[^>]*>+
\ end=+</script>+me=s-1 keepend
\ contains=mustacheInside,@htmlMustacheContainer,htmlTag,htmlEndTag,htmlTagName,htmlSpecialChar
nnoremap -3 :setfiletype mustache<cr>

" enable django syntax
nnoremap -4 :setfiletype htmldjango.html<cr>

