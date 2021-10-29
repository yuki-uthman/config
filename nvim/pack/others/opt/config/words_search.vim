

function! s:words(...) abort
  
  let words = copy(a:000)

  " very nomagic
  " let string = '\V\(\^\.\*'
  " let string = '\V\(\^\s\*\zs\.\*'
  " let string ..= join(words, '\.\{-}')
  " let string ..= '\.\*\)\|'

  let string = '\V\(\^\s\*\zs\.\*'
  let string ..= join(words, '\.\{-}')
  let string ..= '\.\*\)\|'
  
  " TODO permutations not only reverse
  let words = reverse(words)
  " let string ..= '\(\^\.\*'
  " let string ..= '\(\^\s\*\zs\.\*'
  let string ..= '\(\^\s\*\zs\.\*'
  let string ..= join(words, '\.\{-}')
  let string ..= '\.\*\)'
  call feedkeys('/'..string.."\<CR>")
endfunc

command! -nargs=+ WordsSearch call <SID>words(<f-args>)
cnoreabbrev <expr> ws  (getcmdtype() ==# ':' && getcmdline() ==# 'ws')  ? 'WordsSearch'  : 'ws'
