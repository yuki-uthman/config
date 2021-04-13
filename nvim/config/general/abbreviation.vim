" func Eatchar(pat)
   " let c = nr2char(getchar(0))
   " return (c =~ a:pat) ? '' : c
" endfunc

" cabbrev findrb find **.rb<LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar(' ')<CR>

" function! MoveToEnd()
  " let cmd = getcmdline() 
  " call setcmdpos(strlen(cmd)+1)
  " return cmd
" endfunction

" cnoremap <C-E> <C-\>eMoveToEnd()<CR>

