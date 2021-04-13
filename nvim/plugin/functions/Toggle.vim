nnoremap tq :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction


" nnoremap tv :call VifmToggle()<CR>
" 
" let g:vifm_is_open = 0
" 
" function! VifmToggle()
"   if g:vifm_is_open
"     normal ZZ
"     let g:vifm_is_open = 0
"     execute g:vifm_return_to_window . "wincmd w"
"   else 
"     let g:vifm_return_to_window = winnr()
"     vnew
"     execute 'Vifm'
"     let g:vifm_is_open = 1
"   endif
" endfunction

