
function! ColemakAdd()
  " hnei as hjkl
  nnoremap n j
  nnoremap e k
  nnoremap i l

  " Retain n position
  nnoremap k n
  nnoremap K N

  " Retain i position
  nnoremap u i
  nnoremap U I

  " Retain u position
  nnoremap l u
  nnoremap L <C-r>
endfunction

function! ColemakDelete()
  " hnei as hjkl
  unmap n j
  unmap e k
  unmap i l

  " Retain n position
  unmap k n
  unmap K N

  " Retain i position
  unmap u i
  unmap U I

  " Retain u position
  unmap l u
  unmap L <C-r>
endfunction


command! ColemakAdd call ColemakAdd()
command! ColemakDelete call ColemakDelete()
