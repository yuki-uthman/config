
" fold based on marker 
setlocal foldmethod=marker
setlocal formatoptions-=o

" save and run vim file 
nnoremap <silent><buffer> <leader>r :so %<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


runtime OPT lookup.vim
packadd decho



" packadd vim-markbar

" lua require'cmp'.setup.buffer {
" \   completion = {
" \     autocomplete = false
" \   },
" \   sources = {
" \     { name = 'nvim_lsp' },
" \     { name = 'path' },
" \   },
" \ }


