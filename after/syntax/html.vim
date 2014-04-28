unlet b:current_syntax
syn include @HTML $VIMRUNTIME/syntax/html.vim
syn region htmlTemplate start=+<script [^>]*type *=[^>]*text/ng-template[^>]*>+ keepend end=+</script>+me=s-1 contains=@HTML,htmlScriptTag,@htmlPreproc
