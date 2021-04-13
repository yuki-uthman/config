
" noremap <leader>v :call cursor(2,15)<CR>
" nnoremap <leader>D :normal! mqd$<esc>`q
"jnnoremap time "=strftime("%a %d %H:%M")<CR>P
"
function! Move(row,col)
  call cursor(a:row, a:col)
endfunction


function! Clear(repeat)
  let cursor_pos = getpos('.')
  for i in range(0, a:repeat)
    call cursor(cursor_pos[1] + i , 8)
    exec "normal! d$j"
  endfor
endfunction


" Append log from current line onwards
function! AppendTimeLog(repeat)
    let cursor_pos = getpos('.')
    echo cursor_pos
    call cursor(cursor_pos[1], 0)
    let today = strftime("%d/%m")
    for i in range(1, a:repeat)
      exec "normal! A " . today 
      exec "normal! j\<ESC>"
    endfor
endfunction

