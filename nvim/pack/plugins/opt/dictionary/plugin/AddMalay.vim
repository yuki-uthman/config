
function! MalayAdd()
  set dict+=~/.config/nvim/dict/malay.dic
endfunction

function! MalayDelete()
  set dict-=~/.config/nvim/dict/malay.dic
endfunction


command! MalayAdd call MalayAdd()
command! MalayDelete call MalayDelete()
