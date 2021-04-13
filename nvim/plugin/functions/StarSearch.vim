" Put visually selected text in the search register without moving
" vnoremap * :call <SID>getSelectedText(visualmode())<cr>
function! GetSelectedText(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif
    let @/= @@
    let @@ = saved_unnamed_register
endfunction

" Press * highlights the current word
" Press one more time to disable the highlight
" nnoremap <silent> <expr> * Highlighting()
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
