" nnoremap rm :call delete(expand('%')) \| bdelete!<CR>

command! -nargs=* Delete :call Delete("<args>")

function! s:Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

function! Delete(name)
  if a:name 
    call delete(a:name)
  else 
    call delete(expand('%'))
  endif
  bdelete!
endfunction

autocmd CmdwinEnter * inoreabbrev <silent> <buffer> <expr> d "Delete\<C-R>=<SID>Eatchar(' ')\<CR>"

cnoreabbrev <expr> d  (getcmdtype() ==# ':' && getcmdline() ==# 'd')  ? 'Delete'  : 'delete'
