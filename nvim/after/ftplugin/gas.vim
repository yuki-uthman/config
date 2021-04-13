
setlocal tabstop=4
setlocal shiftwidth=4

function! s:Make()

  let filename = expand('%:r') 
  let ext = expand('%:e')
  " as --32 -ggdb exit.s -o exit.o
  " ld -m elf_i386 exit.o -o exit

  let as = 'as --32 -ggdb ' . filename . '.' . ext . ' -o ' . filename . '.o'
  let linker = 'ld -m elf_i386 ' . filename . '.o' . ' -o ' . filename

  echo as
  echo system(as)

  echo linker
  echo system(linker)
  
  let run = './' . filename
  echo system( run )

  let rm = 'rm ' . filename . '.o'
  echo system( rm )

endfunction

" call s:Make()
nnoremap <buffer> <leader>r :call <SID>Make()<CR>

