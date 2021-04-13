

setlocal foldmethod=marker

" let b:undo_ftplugin .= '|setlocal foldmethod<'

nnoremap          <buffer> <leader>r :so %<esc>
nnoremap          <buffer> <leader>c :call ToggleCalendar()<CR>

nnoremap <silent> <buffer> <Down>  :call vimwiki#base#find_next_link()<CR>
nnoremap <silent> <buffer> <Up>    :call vimwiki#base#find_prev_link()<CR>
nnoremap <silent> <buffer> <Left>  :call vimwiki#base#go_back_link()<CR>
nnoremap <silent> <buffer> <Right> :call vimwiki#base#follow_link('nosplit', 0, 1)<CR>

nmap <silent> <buffer> <Enter> <Plug>VimwikiToggleListItem

" inoremap          <silent> <buffer> <C-J> <Down>
" inoremap          <silent> <buffer> <C-K> <Up>
" inoremap <nowait> <silent> <buffer> <C-L> <RIGHT>
" inoremap <nowait> <silent> <buffer> <C-H> <LEFT>


" nnoremap <silent> <buffer> ll normal! mqI[[<ESC>A]]<EC>`q

" nnoremap <silent> <buffer> <TAB> normal! za<CR>


