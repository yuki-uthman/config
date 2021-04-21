" nnoremap rm :call delete(expand('%')) \| bdelete!<CR>

command! -nargs=* -complete=file -bang Delete :call Delete("<args>", "<bang>")

function! Delete(name, bang)
  if a:name 
    call delete(a:name)
  else 
    call delete(expand('%'))
  endif
  bdelete!
endfunction

cnoreabbrev <expr> delete  (getcmdtype() ==# ':' && getcmdline() ==# 'delete')  ? 'Delete'  : 'delete'
" cnoreabbrev delete Delete <C-R>=expand("%:t")<CR>
