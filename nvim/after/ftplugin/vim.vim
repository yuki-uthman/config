
" fold based on marker 
setlocal foldmethod=marker

" save and run vim file 
nnoremap <buffer> <leader>r :w<CR>:so %<CR>

runtime config/packs/lookup.vim
packadd vim-lookup

runtime config/packs/decho.vim
packadd decho
