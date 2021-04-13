
setlocal tabstop=4
setlocal shiftwidth=4

function! s:Make()

  let filename = expand('%:r') 
  let ext = expand('%:e')
  let nasm = 'nasm -f elf -g -F dwarf ' . filename . '.' . ext
  let linker = 'ld -m elf_i386 ' . filename . '.o' . ' -o ' . filename

  echo nasm
  echo system(nasm)

  echo linker
  echo system(linker)
  
  let run = './' . filename
  echo system( run )

  let rm = 'rm ' . filename . '.o'
  echo system( rm )

endfunction

" call s:Make()
nnoremap <buffer> <leader>r :call <SID>Make()<CR>

