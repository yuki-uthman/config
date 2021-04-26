function! CreateLink(...)
  if a:0 == 0
    " puts the visual selection into the register
    normal! gv"vy
    " call s:SearchForTerm()
    return
  else
    let url = a:1
  endif
  normal! gv
  normal! mm
  execute 'normal! "lc[l][]'
  let current_line = line('.')
  let markdown_h2_pattern = '\v^(\w+.*\n-+|#{2,3}\s+\w+)'
  let next_match_line = search(markdown_h2_pattern)
  if next_match_line == 0 || next_match_line < current_line
    let target_line = line('$')
  else
    let target_line = next_match_line - 2
  endif
  let formatted_link = '[' . @l . ']: ' . url
  call append(target_line, formatted_link)
  call s:EnsureLineAbove(target_line)
  normal! `m
endfunction

function! s:EnsureLineAbove(target_line)
  if !s:ContentsAreEmptyOrLink(getline(a:target_line))
    call append(a:target_line, '')
  endif
endfunction

function! s:ContentsAreEmptyOrLink(contents)
  let contents_are_link = match(a:contents, '\v\[.*\]:\s')
  return (a:contents == '') || (contents_are_link != -1)
endfunction

" vnoremap <buffer> zl :call CreateLink()<cr>
