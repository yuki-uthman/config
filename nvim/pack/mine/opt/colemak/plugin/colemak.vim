
function! ColemakActivate()
  " hnei as hjkl
  nnoremap n j
  " nnoremap e k
  vnoremap n j
  " vnoremap e k
  xnoremap n j
  " xnoremap e k

  " use j as n
  nnoremap j n
  nnoremap J N

  " use N as Join
  nnoremap N J

  " remap e 
  " nnoremap j e
  " vnoremap j e
  " xnoremap j e
  
  " Disable scroll with Ctrl-f
  nnoremap <C-f> <C-E>

endfunction

function! ColemakDeactivate()
  " ne as jk
  nunmap n
  nunmap e
  vunmap n
  vunmap e
  xunmap n
  xunmap e

  " Retain n position
  nunmap k
  nunmap K

  " remap e 
  nunmap j e
  vunmap j e
  xunmap j e

  " Disable scroll with Ctrl-f
  nunmap <C-f>
endfunction


command! ColemakActivate call ColemakActivate()
command! ColemakDeactivate call ColemakDeactivate()
