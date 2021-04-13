
function! Toggle()

  let s:pat_mark_todo = '^\(\s*[-+*]\?\s*\)\[ \]'
  let s:pat_mark_done = '^\(\s*[-+*]\?\s*\)\[' . g:simple_todo_tick_symbol . ']'

  let task = search(s:pat_mark_todo)

endfunction




