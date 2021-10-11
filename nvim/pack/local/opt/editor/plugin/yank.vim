

nnoremap <silent> y :<C-U>call MarkAndSetOpfunc()<CR>g@
vnoremap <silent> y :<C-U>call MarkYankAndJump()<CR>

nnoremap <silent> yy yy

function! MarkAndSetOpfunc()
    let g:save_cursor = getpos(".")
    set opfunc=YankAndJumpBack
endfunction

function! MarkYankAndJump()
    let g:save_cursor = getpos(".")
    call YankAndJumpBack(visualmode(), 1)
endfunction

function! YankAndJumpBack(type, ...)
    if a:0
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]y"
    else
        silent exe "normal! `[v`]y"
    endif
    call setpos('.', g:save_cursor)
endfunction

vnoremap y ygv<Esc>

