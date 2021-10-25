
function! s:echo_highlight() abort
  let name = synIDattr(synID(line('.'), col('.'), 1), 'name')
  execute 'highlight' name
 
endfunc

nnoremap <leader>h <cmd>call <sid>echo_highlight()<CR>
