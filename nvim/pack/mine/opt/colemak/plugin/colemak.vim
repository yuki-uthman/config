
function! ColemakActivate()
  " hnei as hjkl
  nnoremap n j
  nnoremap e k
  nnoremap i l
  vnoremap n j
  vnoremap e k
  vnoremap i l
  xnoremap n j
  xnoremap e k
  xnoremap i l

  " Retain n position
  nnoremap k n
  nnoremap K N

  " Retain i position
  nnoremap u i
  nnoremap U I

  " Retain u position
  nnoremap l u
  nnoremap L <C-r>

  " remap e 
  nnoremap j e
  vnoremap j e
  xnoremap j e

  " Disable scroll with Ctrl-f
  nnoremap <C-f> <Nop>

endfunction

function! ColemakDeactivate()
  " hnei as hjkl
  nunmap n
  nunmap e
  nunmap i
  vunmap n
  vunmap e
  vunmap i
  xunmap n
  xunmap e
  xunmap i

  " Retain n position
  nunmap k
  nunmap K

  " Retain i position
  nunmap u
  nunmap U

  " Retain u position
  nunmap l 
  nunmap L

  " remap e 
  nunmap j e
  vunmap j e
  xunmap j e

  " Disable scroll with Ctrl-f
  nunmap <C-f>
endfunction


command! ColemakActivate call ColemakActivate()
command! ColemakDeactivate call ColemakDeactivate()
