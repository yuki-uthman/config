" smooth scroll #vim
" https://www.reddit.com/r/vim/comments/bh6u5q/smooth_scroll_in_vim/

nnoremap <silent> <c-u> :call <sid>smoothScroll(1)<cr>
nnoremap <silent> <c-d> :call <sid>smoothScroll(0)<cr>

fun! s:smoothScroll(up)
  execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
  redraw
  for l:count in range(3, &scroll, 2)
    sleep 20m
    execute "normal! " . (a:up ? "\<c-y>" : "\<c-e>")
    execute "normal! " . (a:up ? "k" : "j")
    redraw
  endfor
  " bring the cursor in the middle of screen 
endf

