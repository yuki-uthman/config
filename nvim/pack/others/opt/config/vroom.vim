
function! s:vroom() abort
  call cursor(1, 1)

  silent! %s/\^@/\r/g

  let lnum = search('FAILED', 'n')

  if lnum == 0
    q!
    return
  endif

  let failed_file = getline(lnum - 1)

  let expected_string = getline(lnum)
  let error_lnum = str2nr(matchstr(expected_string, '\d\+'))
  let expected = matchstr(expected_string, 'Expected "\zs.\{-}\ze ')
  let expected = expected[:-2]

  let found_lnum = search('Found:', 'n')
  let line = getline(found_lnum + 1)
  let actual = matchstr(line, '\d\+\s\zs.*\ze <<<<')

  exec 'edit' failed_file
  exec error_lnum
  normal! zz

  call nvim_buf_set_virtual_text(0, -1, error_lnum - 1, [[actual, "Error"]], {})

  " echom failed_file .. ":" .. error_lnum
  " echom "-------12345678901234567890123456789-------"
  " echom "Expect:" .. expected
  " echom "Actual:" .. actual
endfunc

command! Vroom call s:vroom()

