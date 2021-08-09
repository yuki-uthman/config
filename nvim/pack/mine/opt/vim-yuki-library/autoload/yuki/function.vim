
" inside the function call it with expand('<sfile>')
" like so
" yuki#function#name(expand('<sfile>'))
function! yuki#function#name(context)
  return substitute(a:context, '.*\(\.\.\|\s\)', '', '')
endfunction


