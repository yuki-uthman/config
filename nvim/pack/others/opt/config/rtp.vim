

function! s:rtp() abort
  let list = split(&rtp, ',')
  for rtp in list
    echo rtp
  endfor
endfunc

command! Rtp call s:rtp()
cnoreabbrev <expr> rtp  (getcmdtype() ==# ':' && getcmdline() ==# 'rtp')  ? 'Rtp'  : 'rtp'

