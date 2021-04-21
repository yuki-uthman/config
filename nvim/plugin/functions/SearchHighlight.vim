fun! SearchHighlight()
    silent! call matchdelete(b:ring)
    let b:ring = matchadd('IncSearch', '\c\%#' . @/, 101)
endfun

fun! SearchNext()
    try
        execute 'normal! ' . 'Nn'[v:searchforward]
    catch /E385:/
        echohl IncSearch | echo "E385: search hit BOTTOM without match for: " . @/ | echohl None
    endtry
    call SearchHighlight()
    " call s:positionCursor(10)
endfun

fun! SearchPrev()
    try
        execute 'normal! ' . 'nN'[v:searchforward]
    catch /E384:/
        echohl IncSearch | echo "E384: search hit TOP without match for: " . @/ | echohl None
    endtry
    call SearchHighlight()
    " call s:positionCursor(10)
endfun

func! s:positionCursor(i)
  exec "normal! zt"
  let down = repeat("\<C-Y>", a:i)
  exec "normal! " . down
endfunc


" Highlight entry
nnoremap <silent> n :call SearchNext()<CR>
nnoremap <silent> N :call SearchPrev()<CR>

" Use <C-L> to clear some highlighting
" nnoremap <silent> <C-L> :silent! call matchdelete(b:ring)<CR>:nohlsearch<CR>:set nolist nospell<CR><C-L>
