" function! OpfuncSteady()
"   if !empty(&operatorfunc)
"     call winrestview(w:opfuncview)
"     unlet w:opfuncview
"     noautocmd set operatorfunc=
"   endif
" endfunction

" augroup OpfuncSteady
"   autocmd!
"   autocmd OptionSet operatorfunc let w:opfuncview = winsaveview()
"   autocmd CursorMoved * call OpfuncSteady()
" augroup END
