

cnoremap <C-z> <C-\>e(<SID>MakeItFuzzy())<CR>

function! s:MakeItFuzzy()
  let l:cmdlineBeforeCursor = strpart(getcmdline(), 0, getcmdpos() - 1)
  let l:cmdlineAfterCursor = strpart(getcmdline(), getcmdpos() - 1)

  let l:words = split(cmdlineBeforeCursor, ' ')
  let l:cmdlineBeforeCursor = join(l:words[:-2], ' ')

  let l:last_word = l:words[-1]

  " delete * if it has * in the beginning of the word
  if l:last_word[0] == '*'
    let l:last_word = l:last_word[1:]
  endif

  let l:fuzzy_word = ''
  for c in split(l:last_word, '\zs')
    " only add * if the char is not *
    if c != '*'
      let l:fuzzy_word = l:fuzzy_word . '*' . c
    endif
  endfor
  " check if the first letter of the cmd after cursor is *
  " add * if there is none
  if l:cmdlineAfterCursor[0] != '*'
    let l:fuzzy_word = l:fuzzy_word . '*'
  endif
  let l:result = l:cmdlineBeforeCursor . ' ' . l:fuzzy_word . l:cmdlineAfterCursor
  call setcmdpos(strlen(l:result) + 1)
  return l:result
endfunction
