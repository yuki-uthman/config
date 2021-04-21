
function! AddMalay()
  set dict+=~/.config/nvim/dict/malay.dic
endfunction

function! RemoveMalay()
  set dict-=~/.config/nvim/dict/malay.dic
endfunction


command! AddMalay call AddMalay()
command! RemoveMalay call RemoveMalay()
